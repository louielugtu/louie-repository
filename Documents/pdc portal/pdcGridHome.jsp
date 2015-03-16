<%@ page import="com.epicentric.common.Installation,
                     com.epicentric.common.website.*,
                     java.util.*,
                     com.epicentric.template.*"
%>
<%@ taglib uri="vgn-tags" prefix="vgn-portal" %>
<vgn-portal:defineObjects/>
<%!
     public static String brighter(String color) {
         int SCALE = 14;
         String newColor = color;

         try {
             String sColor = color;

             if (!sColor.startsWith("#")) {
                 sColor = "#" + sColor;
             }

             int intColor = Integer.decode(sColor).intValue();
             java.awt.Color awtColor = new java.awt.Color(intColor);

             if (awtColor != null) {
                 int r = awtColor.getRed();
                 int g = awtColor.getGreen();
                 int b = awtColor.getBlue();

                 r += SCALE;
                 g += SCALE;
                 b += SCALE;

                 awtColor = new java.awt.Color(Math.min(r, 255), Math.min(g, 255), Math.min(b, 255));
                 intColor = (256 * 256 * awtColor.getRed()) + (256 * awtColor.getGreen()) + awtColor.getBlue();
                 newColor = Integer.toString(intColor, 16);

                 while (newColor.length() < 6) {
                     newColor = "0" + newColor;
                 }
             }
         } catch (NumberFormatException e) {
             // just return the color that was passed in
         }

         return newColor;
     }
%>

<%
     Style _thisStyleObject = portalContext.getCurrentStyle();
     String _pathToImages = portalContext.getPortalHttpRoot() + _thisStyleObject.getUrlSafeRelativePath();

     // background color used by vertical nav, vertical footer, and spacer row between horizontal nav and rest of the page
     String bgColor = brighter(EndUserUtils.getCachedBranding(pageContext).getColorValue("bgColor.bg4"));
%>

<!-- Vignette Portal <%=Installation.getVersion()%> -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<vgn-portal:pageContentTitle />
	<vgn-portal:styleBlock />
    <script language="JavaScript" src="<%= HtmlUtils.getPath(HtmlUtils.JS_LIBRARY_PATH) %>/form_state_manager.js"></script>
    <noscript><vgn-portal:i18nValue stringID="<%= _thisStyleObject.getUID() %>" key="noscript" defaultValue="In order to bring you the best possible user experience, this site uses Javascript. If you are seeing this message, it is likely that the Javascript option in your browser is disabled. For optimal viewing of this site, please ensure that Javascript is enabled for your browser."/>
    </noscript>
    <style type="text/css">
        .epi-calculated-bg {background-color: #<%=bgColor%>}
    </style>
<base target="_top">
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" class="epi-pageBG">

<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
	<tr height="28">
		<td colspan="2" style="padding-bottom:1px" height="28">
			<table border="0" cellspacing="0" cellpadding="0" width="100%" class="epi-BG1">
				<tr >
					<td height="28">
						<img src="<%=_pathToImages%>spacer.gif" border="0" alt="" width="9" height="1" /></td>
					<td width="100%" nowrap height="28">
						<!-- begin header area -->
						<vgn-portal:includeStyle friendlyID="PDC_STYLE_TYPE_HEADER"/>
						<!-- end header area -->
					</td>
					<td nowrap valign="middle" align="right" style="padding-right:8px" height="28">
						<!-- begin site controls area -->
						<!-- <vgn-portal:includeStyle friendlyID="site_controls"/> -->
						<!-- end site controls area -->
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr height="19">
		<td colspan="2" style="padding-bottom:1px" height="19">
			<!-- begin account controls area -->
			<!-- <vgn-portal:includeStyle friendlyID="account_controls"/> -->
			<!-- end account controls area -->
		</td>
	</tr>
	<tr>
		<td colspan="2" height="1">
			<!-- begin horizontal nav area -->
			<vgn-portal:includeNavigation friendlyID="PDC_STYLE_TYPE_HORIZONTAL_NAVIGATION" />
			<!-- end horizontal nav area -->
			<table border="0" cellspacing="0" cellpadding="0" width="100%" class="epi-calculated-bg">
				<tr>
					<td><img src="<%=_pathToImages%>spacer.gif" border="0" alt="" width="1" height="10" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top" align="right" style="padding-left:9px; padding-top:26px" width="10" class="epi-calculated-bg">
			<!-- begin vertical nav area -->
			<vgn-portal:includeNavigation friendlyID="navigation-vertical" isSecondary="<%=true%>" />
			<!-- end vertical nav area -->
		</td>
		<td rowspan="2" valign="top" width="100%">
			<a name="mainContent" id="mainContent"></a>
			<!-- begin page content area -->
			<vgn-portal:includePageContent />
			<!-- end page content area -->
		</td>
	</tr>
	<tr>
		<td valign="bottom" class="epi-calculated-bg">
			<!-- begin footer area -->
			<vgn-portal:includeStyle friendlyID="PDC_STYLE_TYPE_FOOTER" />
			<!-- end footer area -->
		</td>
	</tr>
</table>

</body>
</html>
