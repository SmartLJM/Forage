<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
  <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.0/css/bootstrap.min.css" rel="stylesheet"/>
  <!--<link href="css/global.css" rel="stylesheet"/>-->
  <link href="${pageContext.request.contextPath}/static/css/non-responsive.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/static/css/global.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/static/css/login.css" rel="stylesheet">
  <title>觅食</title>
</head>
<body>
	<div class="header">
		<img class="logo" src="${pageContext.request.contextPath}/static/img/logo_login.png"/>
  </div>
  <div class="cantainer main">
   	<div class="promotion-banner tag-left">
			<img src="${pageContext.request.contextPath}/static/img/login_img.png"/>
   	</div>
   	<div class="login-section tag-left">
   		<form action="${pageContext.request.contextPath}/signin" method="post">
			<%@ include file="component/alertDiv.jsp" %>
   			<div class="form-head">
					<span>账号登录</span>
   			</div>
   			<div class="input-group">
				  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-phone"></span></span>
				  <input type="text" class="form-control" name="userName" placeholder="请输入用户名" aria-describedby="basic-addon1">
				</div>
				<div class="input-group">
				  <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-lock"></span></span>
				  <input type="password"  name="password" class="form-control" placeholder="密码" aria-describedby="basic-addon1">
				</div>
				<div class="checkbox"  class="tag-right">
	        <label>
	          <input type="checkbox" class="tag-left">7 天内自动登录
	        </label>
	        <a href="#" class="tag-right">忘记密码?</a>
	   		</div>
	   		<button type="submit" class="btn-login">登录</button>
	   		<p class="signin-tips">还没有账号?<a>免费注册</a></p>
   		</form>
   	</div>
  </div><!--container main-->
  <div class="container footer">
    
  </div>
	<div class="container copyright">
		<p>&copy;2020 开发者：吕继明</p>
	</div>
</body>
<script src="${pageContext.request.contextPath}/static/js/jquery-2.1.4.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<!-- scrollbar 必须在jquery和bootstrap后面 -->
<script src="${pageContext.request.contextPath}/static/js/scrollbar.js"></script>
</html>