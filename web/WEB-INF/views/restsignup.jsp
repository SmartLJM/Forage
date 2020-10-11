<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
  <link href="/static/bootstrap-3.3.0/css/bootstrap.min.css" rel="stylesheet"/>
  <!--<link href="css/global.css" rel="stylesheet"/>-->
  <link href="/static/css/non-responsive.css" rel="stylesheet">
  <link href="/static/css/global.css" rel="stylesheet">
  <link href="/static/css/signin.css" rel="stylesheet">
  <title>觅食</title>
</head>
<body>
	<div class="header">
		<img class="logo" src="/static/img/logo_login.png"/>
  </div>
  <div class="header-divider"></div>
  <div class="cantainer main">
   	<div class="signin-section">
   		<form class="sign-form" action="/restsignup" method="post" enctype="multipart/form-data">
            <%@ include file="component/alertDiv.jsp" %>
            <div class="form-g">
              <span class="input-tip">店铺名</span>
              <input class="form-input" type="text"  name="name"/>
            </div>
            <div class="form-g">
              <span class="input-tip">店铺号码</span>
              <input class="form-input" type="text" name="phoneNum" />
            </div>
            <div class="form-g">
              <span class="input-tip">店铺地址</span>
              <input class="form-input" type="text" name="location"/>
            </div>
            <div class="form-g">
              <span class="input-tip">店铺图片</span>
              <input class="form-input img-input" type="file" name="winImg"/>
            </div>
            <button class="sign-btn" type="submit">同意以下协议并注册</button>
            <a href="http://www.meituan.com/about/terms">《美团网加盟协议》</a>
      </form>
   	</div>
  </div><!--container main-->
  <div class="container footer">
    
  </div>
    <div class="container copyright">
        <p>&copy;2020 开发者：吕继明</p>
    </div>
</body>
<script src="/static/js/jquery-2.1.4.min.js"></script>
<script src="/static/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<!-- scrollbar 必须在jquery和bootstrap后面 -->
<script src="/static/js/scrollbar.js"></script>
</html>