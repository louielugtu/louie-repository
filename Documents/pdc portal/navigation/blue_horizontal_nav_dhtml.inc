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
<%!
	private static String lev0BorderClass = "epi-horzMenu-border-baseLevel";
	private static String lev0Class = "epi-horzMenu-baseLevel";
	private static String lev0OverClass = "epi-horzMenu-baseLevel-over";
	private static String lev0SelClass = "epi-horzMenu-baseLevel-select";
	private static String lev0SelOverClass = "epi-horzMenu-baseLevel-select-over";
	private static String lev1BorderClass = "epi-horzMenu-border-subLevel";
	private static String lev1Class = "epi-horzMenu-subLevel";
	private static String lev1OverClass = "epi-horzMenu-subLevel-over";
	private static String lev1SelClass = "epi-horzMenu-subLevel-select";
	private static String lev1SelOverClass = "epi-horzMenu-subLevel-select-over";
%>
<%
	List allNodes = MenuItemUtils.getAllVisibleNodes(portalContext);
	if (allNodes.isEmpty()) return;
	Iterator allPermittedNodes = allNodes.iterator();
	String pathToJSLib = HtmlUtils.getPath(HtmlUtils.JS_LIBRARY_PATH);
	String cssPath = StyleUtils.createCSSStyleSheetLink(portalContext, _thisStyleObject, "style-css.variables.jsp", null);
%>
<link rel="stylesheet" type="text/css" href="<%=cssPath%>">
<div id="hori_anchor" style="position:absolute; overflow:hidden; height:0; width:0;"></div>
<div id="horizontal" style="position:relative; overflow:hidden; height:0; width:0;" class="epi-horzMenu0"></div>
<script language="JavaScript" src="<%=pathToJSLib%>/generic.js"></script>
<script language="JavaScript" src="<%=pathToJSLib%>/dhtmlmenu.js"></script>
<script language="JavaScript" src="<%=_pathToImages%>hminit.js"></script>
<script language="JavaScript">
<%--// Ref: cm_makeLevel(width,height,regClass,overClass,borderX,borderY,borderClass,rows,align,offsetX,offsetY,arrow,arrowWidth,arrowHeight)--%>
hM.level[0]=new cm_makeLevel(10,8,"<%=lev0Class%>","<%=lev0OverClass%>",0.1,0.1,"<%=lev0BorderClass%>",0,"bottom",3,-2,0,0,0,0,1);
hM.level[1]=new cm_makeLevel(10,2,"<%=lev1Class%>","<%=lev1OverClass%>",0.1,0.1,"<%=lev1BorderClass%>",0,"right",-3,2,"<%=_pathToImages%>arrow_black_sm.gif","<%=_pathToImages%>arrow_white_sm.gif",7,7,1);
<%--//Ref: makeMenu (name,parent,txt,lnk,targ,w,h,img1,img2,cl,cl2,align,rows,nolink,onclick,onmouseover,onmouseout) --%>
	<%
		while (allPermittedNodes.hasNext()) {
			MenuItemNode node = (MenuItemNode) allPermittedNodes.next();

			String targetValue = "";
			if (node.inPopup()) {
				// we want to set it to "_blank" because this is how it works with DTHML
				targetValue = "_blank";
			}

			int nodeLevel = node.getLevel();
			String cl1 = "";
			String cl2 = "";
			if (node.wasSelected()) {
				if (nodeLevel == 0) {
					cl1 = lev0SelClass;
					cl2 = lev0SelOverClass;
				} else if (true) {
					cl1 = lev1SelClass;
					cl2 = lev1SelOverClass;
				}
			}
			if (nodeLevel < endLevel) {
				String nodeID = node.getID();
				if (nodeLevel == 0) {
					if (node.isSpacer()) {
						continue;
					}
	%>
<%--//makeMenu = function(name,parent,txt,lnk,targ,w,h,img1,img2,cl,cl2,align,rows,nolink,onclick,onmouseover,onmouseout)--%>
hM.makeMenu('<%= nodeID %>','','<%= node.getTitle() %>','<%= node.getHref() %>','<%=targetValue%>','menu','menu',0,0,'<%=cl1%>','<%=cl2%>');
	<%			} else {
					if (node.isSpacer()) {
	%>
hM.makeMenu('<%= node.getID() %>','<%= node.getParentID() %>','','','',10,5,0,0,0,0,0,0,1);
	<%
					} else {
						String txt = node.getTitle();
	%>
hM.makeMenu('<%= node.getID() %>','<%= node.getParentID() %>','<%=txt%>','<%= node.getHref() %>','<%= targetValue %>','menu','menu',0,0,'<%=cl1%>','<%=cl2%>');
	<%
					}
				}
			}
		}
	%>
hM.construct()
if (bw.ie) {
	appendToHandler("onload","hM.dimensionsInit();");
} else {
	hM.dimensionsInit();
}
if(cm_posCheckE) {
	if(cm_posCheckE.indexOf("hM.reposition()")==-1) cm_posCheckE+="hM.reposition();";
} else cm_posCheckE="hM.reposition();";
appendToHandler("onload","hM.display();hM.reposition();");
</script>
