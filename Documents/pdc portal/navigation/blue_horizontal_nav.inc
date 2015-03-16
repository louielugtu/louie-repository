<%--
Copyright 1999-2003 Vignette Corporation.
All rights reserved.

THIS PROGRAM IS CONFIDENTIAL AND AN UNPUBLISHED WORK AND TRADE
SECRET OF THE COPYRIGHT HOLDER, AND DISTRIBUTED ONLY UNDER RESTRICTION.

EXCEPT AS EXPLICITLY STATED IN A WRITTEN AGREEMENT BETWEEN THE PARTIES,
THE SOFTWARE IS PROVIDED AS-IS, WITHOUT WARRANTIES OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NONINFRINGEMENT,
PERFORMANCE, AND QUALITY.
--%>
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
