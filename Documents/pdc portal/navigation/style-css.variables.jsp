<%--
/*######################################################################################
Copyright 1999-2007 Vignette Corporation.  All rights reserved.  This software
is an unpublished work and trade secret of Vignette, and distributed only
under restriction.  This software (or any part of it) may not be used,
modified, reproduced, stored on a retrieval system, distributed, or
transmitted without the express written consent of Vignette.  Violation of
the provisions contained herein may result in severe civil and criminal
penalties, and any violators will be prosecuted to the maximum extent
possible under the law.  Further, by using this software you acknowledge and
agree that if this software is modified by anyone such as you, a third party
or Vignette, then Vignette will have no obligation to provide support or
maintenance for this software.
#####################################################################################*/ 
--%><%@ page import="com.epicentric.template.Branding,
				 com.epicentric.template.BrandingUtils,
				 com.epicentric.common.website.EndUserUtils,				 
				 com.epicentric.common.website.HtmlUtils"%>
<%@ taglib uri="epi-tags" prefix="epi_html" %>
<epi_html:defineObjects />
<%
	Branding branding = BrandingUtils.getUserBranding(portalContext);

	int clientBrowser = HtmlUtils.sniffBrowser(request);
	String fontSize = BrandingUtils.remapSize(branding.getFontValue("font.body.normal"), clientBrowser);
	String fontFamily = branding.getFontValue("font.body.face");
	String subLevelBorderColor = branding.getColorValue("bgColor.page");
	String bgColor = branding.getColorValue("bgColor.bg4");
	String textColor = branding.getColorValue("fontColor.link3Link");
	String rolloverTextColor = branding.getColorValue("fontColor.font1");
	String rolloverBGColor = branding.getColorValue("bgColor.bg1");
	String selectBGColor = EndUserUtils.changeColorSlightly(branding.getColorValue("bgColor.bg4"), true); // brighten the color
	String pageBGColor = branding.getColorValue("bgColor.page");
%>

.epi-horzMenu0				{position: relative;}

.epi-horzMenu,
.epi-horzMenu-border-baseLevel,
.epi-horzMenu-border-subLevel,
.epi-horzMenu-baseLevel,
.epi-horzMenu-baseLevel-over,
.epi-horzMenu-baseLevel-select,
.epi-horzMenu-baseLevel-select-over,
.epi-horzMenu-subLevel,
.epi-horzMenu-subLevel-over,
.epi-horzMenu-subLevel-select,
.epi-horzMenu-subLevel-select-over,
.epi-menu-img,
.epi-CMEvent	{
	position: absolute;
}

<%-- turns menus off until all are prepared by the javascript; javascript then turns them on --%>
.epi-horzMenu,
.epi-horzMenu-border-baseLevel,
.epi-horzMenu-border-subLevel,
.epi-CMEvent	{
	visibility:hidden;
}

.epi-CMEvent	{
	z-index:300;
	width:100%;
	height:100%;
	clip:rect(0,100%,100%,0);
	left:0;
	top:0;
}

<%-- sets padding for top-level menu items --%>
.epi-horzMenu,
.epi-horzMenu-baseLevel,
.epi-horzMenu-baseLevel-over,
.epi-horzMenu-baseLevel-select,
.epi-horzMenu-baseLevel-select-over {
	padding-left:4px;
	padding-right:6px;
	padding-top:4px;
	padding-bottom:4px;
}

<%-- sets padding for popup menu items --%>
.epi-horzMenu-subLevel,
.epi-horzMenu-subLevel-over,
.epi-horzMenu-subLevel-select,
.epi-horzMenu-subLevel-select-over	{
	padding-left:4px;
	padding-right:6px;
	padding-top:3px;
	padding-bottom:3px;
}

<%-- sets font and cursor attributes for menu --%>
.epi-horzMenu-border-baseLevel,
.epi-horzMenu-border-subLevel,
.epi-horzMenu-baseLevel,
.epi-horzMenu-baseLevel-over,
.epi-horzMenu-baseLevel-select,
.epi-horzMenu-baseLevel-select-over,
.epi-horzMenu-subLevel,
.epi-horzMenu-subLevel-over,
.epi-horzMenu-subLevel-select,
.epi-horzMenu-subLevel-select-over	{
	overflow:hidden;
	cursor:pointer;
	cursor:hand;
	font-size:<%=fontSize%>;
	font-family:<%=fontFamily%>;
}

<%-- sets color of separator between popup menu items --%>
.epi-horzMenu-subLevel,
.epi-horzMenu-subLevel-over,
.epi-horzMenu-subLevel-select,
.epi-horzMenu-subLevel-select-over	{
	vertical-align:bottom;
	border-bottom-style:solid;
	border-bottom-width:1px;
	border-bottom-color:#<%=subLevelBorderColor%>;
}

<%-- puts single-pixel bottom border along length of menu using the page background color --%>
.epi-horzMenu0,
.epi-horzMenu,
.epi-horzMenu-border-baseLevel	{
	vertical-align:bottom;
	border-bottom-style:solid;
	border-bottom-width:1px;
	border-bottom-color:#<%=pageBGColor%>;
}

<%-- turns off border for top-level menu items; if this line is missing, the rollover hilite doesn't fill the whole menu item --%>
.epi-horzMenu-border-baseLevel	{
	border-width:0px;
}

<%-- sets single-pixel bottom border for top-level menu items to same color as page background --%>
.epi-horzMenu-baseLevel,
.epi-horzMenu-baseLevel-over	{
	vertical-align:bottom;
	border-bottom-style:solid;
	border-bottom-width:1px;
	border-bottom-color:#<%=pageBGColor%>;
}

<%-- sets border color for popup menus --%>
.epi-horzMenu-border-subLevel	{
	border-color:#<%=subLevelBorderColor%>;
	border-style:solid;
	border-width:1px;
}

<%-- sets text and background colors for menu and unselected menu items --%>
.epi-horzMenu0,
.epi-horzMenu,
.epi-horzMenu-baseLevel,
.epi-horzMenu-subLevel	{
	color:#<%=textColor%>;
	layer-background-color:#<%=bgColor%>;
	background-color:#<%=bgColor%>;
}

<%-- sets text and background colors for moused-over menu items --%>
.epi-horzMenu-baseLevel-over,
.epi-horzMenu-subLevel-over,
.epi-horzMenu-baseLevel-select-over,
.epi-horzMenu-subLevel-select-over	{
	color:#<%=rolloverTextColor%>;
	layer-background-color:#<%=rolloverBGColor%>;
	background-color:#<%=rolloverBGColor%>;
}

<%-- sets text and background colors for selected menu items --%>
.epi-horzMenu-baseLevel-select,
.epi-horzMenu-subLevel-select	{
	color:#<%=textColor%>;
	layer-background-color:#<%=selectBGColor%>;
	background-color:#<%=selectBGColor%>;
}

<%-- sets the left and right border colors for the selected menu item --%>
.epi-horzMenu-baseLevel-select	{
	border-left-style:solid;
	border-left-width:1px;
	border-left-color:#<%=pageBGColor%>;
	border-right-style:solid;
	border-right-width:1px;
	border-right-color:#<%=pageBGColor%>;
}
