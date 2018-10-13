<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ChenYongP
  Date: 2018-10-11
  Time: 10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

${param.name}

<c:set var="age" value="${param.name}" />

${age}

<c:out value="${age}" />
