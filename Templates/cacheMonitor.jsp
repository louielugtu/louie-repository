<%@ page
import="java.io.*"
import="java.security.*"
import="javax.servlet.*"
import="java.util.*"
import="javax.servlet.http.*"
import="net.sf.ehcache.*"
import="net.voda.portal.common.cache.PortalSharedCacheConfigurer"
import="com.epicentric.common.website.SessionUtils,
				com.epicentric.user.User,
				com.voda.portal.util.UserAccountUtil,
				net.voda.portal.dobject.UserRoles, 
				net.voda.portal.common.cache.PortalSharedCache,
				net.voda.portal.common.cache.PortalSharedCacheFactory,
				org.apache.commons.lang.SerializationUtils"
%>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Servlet Container Cache Monitor</title>
</head>
<body bgcolor="#d1d7b3">
<h2><font color="#0000a0">Servlet Container Cache Monitor</font></h2>
<%
	try {
		Ehcache cache = null;
		CacheManager manager = PortalSharedCacheConfigurer.getSingleton().getCacheManager();
		String[] names = manager.getCacheNames();
		for (String name : names) {
			out.println("<br><br><b>Cache Region Name: "+ name+"</b><br>");
			cache = manager.getEhcache(name);
			out.println("Statistics:  Hits:"+ cache.getStatistics().getCacheHits());
			out.println("&nbsp;&nbsp;In Memory Hits:"+ cache.getStatistics().getInMemoryHits());
			out.println("&nbsp;&nbsp;Misses:"+ cache.getStatistics().getCacheMisses());
			out.println("&nbsp;&nbsp;Eviction:"+ cache.getStatistics().getEvictionCount());
			out.println("&nbsp;&nbsp;Memory Store Count:"+ cache.getStatistics().getMemoryStoreObjectCount());
			out.println("&nbsp;&nbsp;Disk Store Count:"+ cache.getStatistics().getDiskStoreObjectCount());
			out.println("<br>");
			out.println("<br>");
			
			Object value = null;			
			List keys = cache.getKeys();
			for (Object key : keys) {
				out.println("<br>");
				out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Element - key: "+ key +"<br>");
				try {
					value = cache.get(key).getObjectValue();
					value = org.apache.commons.lang.SerializationUtils.deserialize((byte[])value);
					if (value instanceof java.util.List) {
						out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;List Values: <br>");					
						for (Object listItem : ((java.util.List) value)) {
								out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Item: ");
								out.println(""+ listItem +"<br>");
						}
					} else {
						out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Value: "+ value +"<br>");
					}
				} catch (Exception ex) {
					out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Class not loaded by this classloader!<br>");
					ex.printStackTrace();
				}
			}
		}

		PortalSharedCache portalSharedCache = PortalSharedCacheFactory.getSharedCache(); 
		Object ref = PortalSharedCacheConfigurer.getSingleton().getCacheManager().getEhcache("portalOneDayCache"); 
		if (ref != null) out.println("REF OK");
		
	final String cacheKey = "getUserRoles|net.voda.portal.dobject.UserRoles|0823335587.";	
	final byte[] cacheData = portalSharedCache.get("portalOneDayCache", cacheKey);
		

	} catch (Throwable ex) {
		out.println("Error message: "+ ex.getMessage());
	}
%>
</form>
</body>
</html>

