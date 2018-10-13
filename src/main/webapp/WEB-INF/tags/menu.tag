<%@include file="../jsp/include.jsp" %>
<%@tag description="Main Layout Menu" pageEncoding="UTF-8" %>
<%@attribute name="pageParent" %>
<%@attribute name="pageUrl" %>

<!-- <li class="header">HEADER</li> -->
<!-- Optionally, you can add icons to the links -->
<li <c:if test="${pageUrl == '/index'}">class="active"</c:if>><a href="/index"><i class="fa fa-dashboard"></i><span>Dashboard</span></a></li>

<li <c:if test="${pageUrl == '/business'}">class="active"</c:if>><a href="/business"><i class="fa fa-briefcase"></i><span>Business</span></a></li>

<li class="treeview <c:if test='${pageParent == \'Department\'}'>active</c:if>">
    <a href="#"><i class="fa fa-sitemap"></i><span>Department</span><span class="pull-right-container"><i class="fa fa-angle-left pull-right"></i></span></a>
    <ul class="treeview-menu">
        <li <c:if test="${pageUrl == '/department/center'}">class="active"</c:if>><a href="/department/center"><i class="fa fa-institution"></i><span>Center</span></a></li>
        <li <c:if test="${pageUrl == '/department/assistant'}">class="active"</c:if>><a href="/department/assistant"><i class="fa fa-paper-plane"></i><span>Assistant</span></a></li>
    </ul>
</li>

<li <c:if test="${pageUrl == '/setting'}">class="active"</c:if>><a href="/setting"><i class="fa fa-gear"></i><span>Setting</span></a></li>

<shiro:hasAnyRoles name="admin,user">
<li <c:if test="${pageUrl == '/test'}">class="active"</c:if>><a href="/test"><i class="fa fa-eyedropper"></i><span>Test</span></a></li>
</shiro:hasAnyRoles>