<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <!-- 指定字符集 -->
    <meta charset="utf-8"/>
    <!-- 使用Edge最新的浏览器的渲染方式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <!-- viewport视口：网页可以根据设置的宽度自动进行适配，在浏览器的内部虚拟一个容器，容器的宽度与设备的宽度相同。
    width: 默认宽度与设备的宽度相同
    initial-scale: 初始的缩放比，为1:1 -->
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <title>登录</title>
    <!-- 1. 导入CSS的全局样式 -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <!-- 2. jQuery导入，建议使用1.9以上的版本 -->
    <script src="js/jquery-3.3.1.min.js"></script>
    <!-- 3. 导入bootstrap的js文件 -->
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript"></script>

    <script>
        function firstLoad(){
            location.href="${pageContext.request.contextPath}/findAllGoodsByPageServlet?currentPage=1&rows=20";
        }

        function sendMessage(gd_msg){
            if (gd_msg != null && gd_msg !== ""){
                alert(gd_msg);
            }
        }
    </script>
</head>
<body onload="sendMessage('${gd_msg}')">
<%--导航条--%>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid myNav">
        <%--商标--%>
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="javascript:firstLoad()">沃超-市</a>
        </div>


        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <%--左导航--%>

            <ul class="nav navbar-nav">
                <c:if test="${user == null}">
                    <li>
                        <a href="${pageContext.request.contextPath}/login.jsp">登录</a>
                    </li>

                </c:if>
                <c:if test="${user != null}">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${user.u_name}<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="${pageContext.request.contextPath}/userCenterServlet">用户中心</a></li>
                            <li><a href="${pageContext.request.contextPath}/logoutServlet">退出</a></li>

                        </ul>
                    </li>
                </c:if>



            </ul>
            <%--右导航--%>
            <ul class="nav navbar-nav navbar-right">
                <%--搜索框 暂留--%>
                <li>
                    <form class="navbar-form navbar-right">
                        <div class="form-group">
                            <input type="text"  name="g_name" class="form-control" placeholder="请输入要搜索的商品">
                        </div>
                        <button type="submit" class="btn btn-default">搜索</button>
                    </form>
                </li>

                <li><a href="${pageContext.request.contextPath}/myCartsServlet?u_id=${user.u_id}">购物车</a></li>

                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">收藏夹<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/myOrdersServlet?u_id=${user.u_id}">收藏的商品</a></li>
                        <li><a href="#">收藏的店铺</a></li>

                    </ul>
                </li>

            </ul>
        </div>
    </div>
</nav>

    <div>
        <img src="image/goods/${good.g_img}.jpg"/>
    </div>
    <h3>${good.g_name}</h3>
    <p>${good.g_introduce}</p>
    <h4>${good.g_price}</h4>
    <h4>${good.g_stock}</h4>
<%--购买表单--%>
    <form action="" id="buyForm" method="post">
        <input type="hidden" name="u_id" value="${user.u_id}">
        <input type="hidden" name="g_id" value="${good.g_id}">
        <input type="hidden" name="g_name" value="${good.g_name}">
        <input type="hidden" name="g_price" value="${good.g_price}">
        <c:if test="${num == null}">
            <input type="text" name="num" value="1"><br>
        </c:if>
        <c:if test="${num != null}">
            <input type="text" name="num" value="${num}"><br>
        </c:if>
        <%--购买按钮--%>
        <div>
            <c:if test="${good.g_stock > 0}">
                <input class="btn btn-danger" value="购买" id="buyBtn">
            </c:if>
            <c:if test="${good.g_stock <= 0}">
                <input class="btn btn-default " disabled="disabled" value="库存不足" id="buyBtn">
            </c:if>
        </div>
        <%--加入购物车按钮--%>
        <div>
            <input class="btn btn-warning" value="加入购物车" id="cartBtn">
        </div>
        <%--收藏按钮--%>
        <div>
            <c:if test="${gColl_id == 0 }">
                <input class="btn btn-success" value="收藏" id="collectionBtn">
            </c:if>
            <c:if test="${gColl_id != 0}">
                <input class="btn btn-default" value="取消收藏" id="collectionBtn">
            </c:if>
        </div>
    </form>

<script>
    //购买按钮点击事件
    document.getElementById("buyBtn").onclick = function (){
        if (confirm("确定购买？")){
            let buyForm = document.getElementById("buyForm");
            buyForm.action = "${pageContext.request.contextPath}/createOrderServlet";
            buyForm.submit();
        }
    }
    //购物车按钮点击事件
    document.getElementById("cartBtn").onclick = function (){
        if (confirm("确定加入购物车？")){
            let buyForm = document.getElementById("buyForm");
            buyForm.action = "${pageContext.request.contextPath}/addIntoCartServlet";
            buyForm.submit();
        }
    }
    //收藏按钮点击事件
    document.getElementById("collectionBtn").onclick = function (){
        let buyForm = document.getElementById("buyForm");
        buyForm.action = "${pageContext.request.contextPath}/goodCollectionServlet";
        buyForm.submit();
    }
</script>
</body>
</html>
