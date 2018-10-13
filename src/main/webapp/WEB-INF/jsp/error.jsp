<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" href="lib/bootstrap/dist/css/bootstrap.min.css"/>
</head>
<body>
<div class="container">
    <h1>Error</h1>
    Status: ${pageContext.response.status}
    <hr>
    Message: ${pageContext.exception.message}

    <hr>
    <p>
        Please contact the operator with the above information.
    </p>

    ${errors.status}
    ${errors.message}
</div>
</body>
</html>