<%@ page import="javax.servlet.http.*,
				 com.epicentric.common.*,
				 com.epicentric.common.website.*,
				 com.epicentric.components.*,
				 com.epicentric.entity.Entity,
				 com.epicentric.portalbeans.*,
				 com.epicentric.servlets.ServletUtils,
				 com.epicentric.site.*,
				 com.epicentric.template.*,
				 com.epicentric.users.*"
%>
<%@ taglib uri="epi-tags" prefix="epi_html" %>
<%@ taglib uri="vgn-tags" prefix="vgn-portal" %>
<epi_html:defineObjects/>
<%
	Style _thisStyleObject = portalContext.getCurrentStyle();
	String _thisTitle = (_thisStyleObject != null) ? _thisStyleObject.getTitle() : "";
	String _thisStyleID = (_thisStyleObject != null) ? _thisStyleObject.getUID() : "header";
	String _pathToImages = portalContext.getPortalHttpRoot() + _thisStyleObject.getUrlSafeRelativePath();
	String i18nID = _thisStyleObject.getUID();
	String portalHttpRoot = portalContext.getPortalHttpRoot();

	// Get some system colors
	Branding branding = EndUserUtils.getCachedBranding(pageContext);
	String pageBackgroundColor = branding.getColorValue("bgColor.bg1");
%>
<%
 	Site site = portalContext.getCurrentSite();

 	String siteTitle = "";
 	if (site != null) {
		siteTitle = I18nUtils.getValue(site.getUID(), "title", site.getTitle(), session, request);
	}
%>
<span class="epi-font1" style="font-weight:bold; letter-spacing:.25em;"><%=siteTitle%></span>
