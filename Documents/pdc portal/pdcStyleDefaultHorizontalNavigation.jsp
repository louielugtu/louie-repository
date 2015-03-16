
<%@ page import="javax.servlet.http.*,
		 	java.util.*,
		 	java.io.*,
            java.util.*,
            com.epicentric.navigation.*,
            com.epicentric.navigation.display.*,
            com.epicentric.portalbeans.adminbean.*,
            com.epicentric.test.*,
            com.epicentric.entity.*,
            com.epicentric.common.website.*,
	 	    com.epicentric.template.*,
            com.epicentric.template.*,
            com.epicentric.site.*,
            com.epicentric.settings.*,
            com.epicentric.common.*,
            com.vignette.portal.website.enduser.PortalContext"
%>
<%@ taglib uri="epi-tags" prefix="epi_html" %>
<%@ taglib uri="vgn-tags" prefix="vgn-portal" %>
<epi_html:defineObjects />
<vgn-portal:defineObjects />
<%!
// this method is needed for 4.x backwards-compatibility
private static String createColor(String selectedColor) {

	try {
		String sColor = selectedColor;
		if (!sColor.startsWith("#")) {
			sColor = "#"+sColor;
		}
		int intColor = Integer.decode(sColor).intValue();
		java.awt.Color awtColor = new java.awt.Color(intColor);
		String color;
		if (awtColor!=null) {
			float[] hsb = java.awt.Color.RGBtoHSB(awtColor.getRed(),awtColor.getGreen(),awtColor.getBlue(),null);
			hsb[1] = hsb[1] - (hsb[1])/(4);
			hsb[2] = hsb[2] + (1-hsb[2])/4;
			awtColor = java.awt.Color.getHSBColor(hsb[0],hsb[1],hsb[2]);
			intColor = 256*256*awtColor.getRed() + 256*awtColor.getGreen() + awtColor.getBlue();
			color = Integer.toString(intColor,16);
			while (color.length()<6) {
				color = "0"+color;
			}

			return color;

		} else {
			return selectedColor;
		}
	} catch (NumberFormatException e) {
		return selectedColor;
	}
}
%>
<%
	// ##################################
	// These are the only parameters that should be used for menu building...

	Style _thisStyleObject = portalContext.getCurrentStyle();
    String portalHttpRoot = portalContext.getPortalHttpRoot(); // this variable is needed for 4.x backwards-compatibility
    String _pathToImages = portalHttpRoot + _thisStyleObject.getUrlSafeRelativePath();
    String i18nID = _thisStyleObject.getUID(); // this variable is needed for 4.x backwards-compatibility
    Entity currentUser = portalContext.getCurrentUser(); // this variable is needed for 4.x backwards-compatibility
    	
	// Try to get MenuItemParams from request.
	// If not found, create a new one and put it in the request.
	MenuItemParams params = (MenuItemParams) request.getAttribute(ParameterConstants.MENU_ITEM_PARAMS);
	if (params == null) {
		params = new MenuItemParams();
		request.setAttribute(ParameterConstants.MENU_ITEM_PARAMS, params);

		params.startLevel = 1;
		params.endLevel = 4;
		params.target = "bodyFrame";
		params.repressView = RequestUtils.getParameterValuesListByPrefix(request, ParameterConstants.REPRESS_VIEW);
		params.allLevels = MenuItemUtils.generateVisibleMenuItemNodesForAllLevels(portalContext);
	}

	List allLevels = params.allLevels;

	if (allLevels == null || allLevels.isEmpty()) {
 		return;
	}

	int startLevel = 0;
	int endLevel = 0;

	try	{
		startLevel 	= Integer.parseInt((String)request.getAttribute("startLevel"));
		endLevel 	= Integer.parseInt((String)request.getAttribute("endLevel"));
	} catch(Exception e)	{
		LOG.error("In horizontal style:", e);
	}	
%>

<%
	// Setup of MenuItems
	List nodesInHorizontalOrder = MenuItemUtils.getNodesInHorizontalOrder(allLevels, startLevel, endLevel);
	int TOTAL_NUMBER_OF_LEVELS = allLevels.size();
	// end Setup of MenuItems

	boolean onFrontDoor = "PAGE".equals(EndUserUtils.getPageContentType(pageContext));
	boolean usingHorzNav = false;

	Style currentGrid = TemplateUtils.getCurrentGrid(portalContext);
	if (currentGrid != null) {
		usingHorzNav = "BLUE_FRONT_PAGE_HORIZONTAL_ONLY".equals(currentGrid.getFriendlyID());
	}

	Iterator levelsOfOrderedHorizontalNodes  = nodesInHorizontalOrder.iterator();

	if (!levelsOfOrderedHorizontalNodes.hasNext()) {
		// bail out if the menu's empty
		return;
	}

	String colorForThisLevel = EndUserUtils.getCachedBranding(pageContext).getColorValue("bgColor.bg4");
	String tabColor = EndUserUtils.getCachedBranding(pageContext).getColorValue("bgColor.page");
%>

<style type="text/css">
.epi-tab { border-bottom:#<%=tabColor%> solid 1px;}
.epi-tabOn {border: #<%=tabColor%> solid 1px; border-bottom-width:0px;}
.epi-tabSpacer {border-bottom: #<%=tabColor%> solid 1px;}
</style>

<%
	while (levelsOfOrderedHorizontalNodes.hasNext()) {
%>
<table border="0" cellspacing="0" cellpadding="0" width="100%" bgcolor="#<%=colorForThisLevel%>">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="3" style="margin-top: 6px;">
				<tr>
	<%
		String colorForSelectedMenuItemAndNextLevel = colorForThisLevel;
		Iterator orderedNodesForLevel = ((List)levelsOfOrderedHorizontalNodes.next()).iterator();

		while (orderedNodesForLevel.hasNext()) {
			MenuItemNode node = (MenuItemNode) orderedNodesForLevel.next();
			String cssClass = "epi-tab";
			String additionalCss = "";
			String menuItemBackgroundColor = colorForThisLevel;

			if (node.isSelected() || node.wasSelected()) {
				cssClass = "epi-tabOn";
				additionalCss = "style=\"" + ((usingHorzNav && !onFrontDoor) ? "border-bottom-width:1px;" : "")
						+ (node.isSelected() ? "font-weight: bold;" : "") + "\"";

				menuItemBackgroundColor = EndUserUtils.changeColorSlightly(colorForThisLevel, true); //make brighter color
				colorForSelectedMenuItemAndNextLevel = menuItemBackgroundColor;
			}

			String bgColor = "";
			if (!StringUtils.isEmpty(menuItemBackgroundColor)) {
				bgColor = "bgcolor=\"#" + menuItemBackgroundColor + "\"";
			}
			%>

					<td nowrap class="epi-tabSpacer">
						<img src="<%=_pathToImages%>spacer.gif" border="0" alt="" width="1" height="1" /></td>
					<td nowrap class="<%=cssClass%>" <%=additionalCss%> <%=bgColor%>>
		<% if (node.isSpacer()) { %>
			 <img src="<%= _pathToImages %>spacer.gif" border="0" alt="" width="10px" height="3" />
        <% } else if (node.usesImages() && node.hasImages()) { // display images
            MenuItemNodeImage image = null;

            if (node.isSelected()) {
                image = node.getImage(MenuItemNode.IMAGE_SELECTED);
            } else {
                image = node.getImage(MenuItemNode.IMAGE_NORMAL);
            }

        %>
			<a class="epi-link3" <%= node.getTarget()%> href="<%= node.getHref() %>">
            <img src="<%=image.getPath()%>" width="<%=image.getWidth()%>" height="<%=image.getHeight()%>" alt="<%=node.getTitle()%>" border="0">
            </a>
        <%  } else { %>
			 &nbsp;<a href="<%= node.getHref() %>" <%= node.getTarget() %> class="epi-link3"><%= node.getTitle() %></a>&nbsp;
		<%  } %>
					</td>
<%
		} // end this level
		colorForThisLevel = colorForSelectedMenuItemAndNextLevel;
%>
				</tr>
			</table>
		</td>
		<td class="epi-tabSpacer" width="100%" nowrap>
			<img src="<%=_pathToImages%>spacer.gif" border="0" alt="" width="1" height="1" /></td>
	</tr>
</table>
<%
	} // end all levels
%>
