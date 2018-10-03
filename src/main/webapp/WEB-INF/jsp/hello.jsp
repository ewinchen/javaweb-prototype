<%@ include file="include.jsp"%>
<!DOCTYPE html>
<head>
    <title>Hello World!</title>
    <script src="/js/jquery.min.js"></script>
</head>
<body>
<form action="/logout" method="post">
    <input type="submit" value="Logout"/>
</form>

<p id="myp">Will be changed</p>
<button onclick="change()">Change</button>

<p>
    <shiro:hasRole name="admin">admin<br/></shiro:hasRole>
    <shiro:hasRole name="user">user<br/></shiro:hasRole>

    <shiro:hasPermission name="button:view">
        <button>Click Me</button>
    </shiro:hasPermission>
</p>


<script>
    function getApiUrl() {
        return location.protocol + '//' + location.hostname + (location.port ? ':' + location.port : '') + '/api';
    }

    function change() {
        $.ajax({
            url: getApiUrl() + '/search_gknum_info?gknum=hellosecurity',
            method: 'GET',
            success: function (res) {
                console.log(res)
            },
            error: function (err) {
                console.log(err)
            }

        })
    }
</script>
</body>
</html>