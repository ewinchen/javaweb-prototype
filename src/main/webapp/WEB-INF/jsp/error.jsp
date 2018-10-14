<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>

<%
    if (request.getHeader("Accept").equals("application/json")) {
        response.sendError(500);
    }

    StringWriter sw = new StringWriter();
    PrintWriter pw = new PrintWriter(sw);
    if (pageContext != null && pageContext.getException() != null) {
        pageContext.getException().printStackTrace(pw);
    }
    request.setAttribute("stackTrace", sw.toString());
%>

<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <link rel="shortcut icon" href="/img/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" href="/lib/bootstrap/dist/css/bootstrap.min.css"/>
</head>
<body>
<div class="container">
    <h1>Error</h1>
    Status: ${pageContext.response.status}
    <hr>
    Message: ${pageContext.exception.message}
    <hr>
    StackTrace: ${stackTrace}

    <hr>
    <p>
        Please contact the operator with the above information.
    </p>

</div>
</body>
</html>