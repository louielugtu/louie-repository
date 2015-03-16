<%@ page import="javax.servlet.http.*,
				 com.epicentric.template.*"
%>
<%@ taglib uri="epi-tags" prefix="epi_html" %>
<%@ taglib uri="vgn-tags" prefix="vgn-portal" %>
<epi_html:defineObjects/>
<%
    String portalHttpRoot = portalContext.getPortalHttpRoot();
    Style _thisStyleObject = portalContext.getCurrentStyle();
    String _pathToImages = portalHttpRoot + _thisStyleObject.getUrlSafeRelativePath();
    String i18nID = _thisStyleObject.getUID();
%>
<table border="0" cellspacing="0" cellpadding="0" width="100%" >
	<tr>
		<td align="center">
			<vgn-portal:i18nElement><img src="<%= _pathToImages %>new-badge.gif" border="0" alt='<vgn-portal:i18nValue stringID="<%= i18nID %>" key="powered_by_vignette" defaultValue="Powered by Vignette" />' title='<vgn-portal:i18nValue stringID="<%= i18nID %>" key="powered_by_vignette" defaultValue="Powered by Vignette" />' width="100" height="31" hspace="10" /></vgn-portal:i18nElement>
			<br />
			<br />
		</td>
	</tr>
</table>

