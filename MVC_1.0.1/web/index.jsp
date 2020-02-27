<%-- 
    Document   : index
    Created on : Feb 24, 2020, 6:35:45 PM
    Author     : meass
--%>

<%@page import="DBOperation.DBOperation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
                *,
*::before,
*::after {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: Roboto, -apple-system, 'Helvetica Neue', 'Segoe UI', Arial, sans-serif;
	background: #fcf3ec;
}
.forms-section {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.section-title {
	font-size: 32px;
	letter-spacing: 1px;
    color: #fff;
    font-family: 'Pacifico', cursive;
}

.forms {
	display: flex;
	align-items: flex-start;
	margin-top: 30px;
}

.form-wrapper {
	animation: hideLayer .3s ease-out forwards;
}

.form-wrapper.is-active {
	animation: showLayer .3s ease-in forwards;
}

@keyframes showLayer {
	50% {
		z-index: 1;
	}
	100% {
		z-index: 1;
	}
}

@keyframes hideLayer {
	0% {
		z-index: 1;
	}
	49.999% {
		z-index: 1;
	}
}

.switcher {
	position: relative;
	cursor: pointer;
	display: block;
	margin-right: auto;
	margin-left: auto;
	padding: 0;
	text-transform: uppercase;
	font-family: 'Fredoka One', cursive;
	font-size: 16px;
	letter-spacing: .5px;
	color: #999;
	background-color: transparent;
	border: none;
	outline: none;
	transform: translateX(0);
	transition: all .3s ease-out;
}

.form-wrapper.is-active .switcher-login {
	color:	#e55743;
	transform: translateX(90px);
}

.form-wrapper.is-active .switcher-signup {
	color: 	#e55743;
	transform: translateX(-90px);
}

.underline {
	position: absolute;
	bottom: -5px;
	left: 0;
	overflow: hidden;
	pointer-events: none;
	width: 100%;
	height: 2px;
}

.underline::before {
	content: '';
	position: absolute;
	top: 0;
	left: inherit;
	display: block;
	width: inherit;
	height: inherit;
	background-color: currentColor;
	transition: transform .2s ease-out;
}

.switcher-login .underline::before {
	transform: translateX(101%);
}

.switcher-signup .underline::before {
	transform: translateX(-101%);
}

.form-wrapper.is-active .underline::before {
	transform: translateX(0);
}

.form {
	overflow: hidden;
	min-width: 260px;
	margin-top: 50px;
	padding: 30px 25px;
  border-radius: 5px;
	transform-origin: top;
}

.form-login {
	animation: hideLogin .3s ease-out forwards;
}

.form-wrapper.is-active .form-login {
	animation: showLogin .3s ease-in forwards;
}

@keyframes showLogin {
	0% {
		background: #d7e7f1;
		transform: translate(40%, 10px);
	}
	50% {
		transform: translate(0, 0);
	}
	100% {
		background-color: #fff;
		transform: translate(35%, -20px);
	}
}

@keyframes hideLogin {
	0% {
		background-color: #fff;
		transform: translate(35%, -20px);
	}
	50% {
		transform: translate(0, 0);
	}
	100% {
		background: #d7e7f1;
		transform: translate(40%, 10px);
	}
}

.form-signup {
	animation: hideSignup .3s ease-out forwards;
}

.form-wrapper.is-active .form-signup {
	animation: showSignup .3s ease-in forwards;
}

@keyframes showSignup {
	0% {
		background: #d7e7f1;
		transform: translate(-40%, 10px) scaleY(.8);
	}
	50% {
		transform: translate(0, 0) scaleY(.8);
	}
	100% {
		background-color: #fff;
		transform: translate(-35%, -20px) scaleY(1);
	}
}

@keyframes hideSignup {
	0% {
		background-color: #fff;
		transform: translate(-35%, -20px) scaleY(1);
	}
	50% {
		transform: translate(0, 0) scaleY(.8);
	}
	100% {
		background: #d7e7f1;
		transform: translate(-40%, 10px) scaleY(.8);
	}
}

.form fieldset {
	position: relative;
	opacity: 0;
	margin: 0;
	padding: 0;
	border: 0;
	transition: all .3s ease-out;
}

.form-login fieldset {
	transform: translateX(-50%);
}

.form-signup fieldset {
	transform: translateX(50%);
}

.form-wrapper.is-active fieldset {
	opacity: 1;
	transform: translateX(0);
	transition: opacity .4s ease-in, transform .35s ease-in;
}

.form legend {
	position: absolute;
	overflow: hidden;
	width: 1px;
	height: 1px;
	clip: rect(0 0 0 0);
}

.input-block {
	margin-bottom: 20px;
}

.input-block label {
	font-size: 14px;
  color: #a1b4b4;
}

.input-block input {
	display: block;
	width: 100%;
	margin-top: 8px;
	padding-right: 15px;
	padding-left: 15px;
	font-size: 16px;
	line-height: 40px;
	color: #3b4465;
  background: #eef9fe;
  border: 1px solid #cddbef;
  border-radius: 2px;
}

.form [type='submit'] {
	opacity: 0;
	display: block;
	min-width: 120px;
	margin: 30px auto 10px;
	font-size: 18px;
	line-height: 40px;
	border-radius: 25px;
	border: none;
	transition: all .3s ease-out;
}

.form-wrapper.is-active .form [type='submit'] {
	opacity: 1;
	transform: translateX(0);
	transition: all .4s ease-in;
}

.btn-login {
	color: #fbfdff;
	background: #a7e245;
	transform: translateX(-30%);
}

.btn-signup {
	color: #a7e245;
	background: #fbfdff;
	box-shadow: inset 0 0 0 2px #a7e245;
	transform: translateX(30%);
}

  
  
.rainbow{
    animation: rainbow 2.5s linear;
    animation-iteration-count: infinite;
}
@keyframes rainbow{
          100%,0%{
              color: #beebe9;
          }
          10%{
              color: #f4dada;
          }
          15%{
              color: #ffb6b9;
          }
          20%{
              color: #f6eec7;
          }
          25%{
              color: #ffc7c7;
          }
          30%{
              color: #ff80b0;
          }
          35%{
              color: #9399ff;
          }
          40%{
              color: #a9fffd;
          }
          45%{
              color: #40e0d0;
          }
          50%{
              color: #ff2e63;
          }
          55%{
              color: #c81912;
          }
          60%{
              color: #f64b3c;
          }
          65%{
              color: #faafff;
          }
          70%{
              color: #e1f2fb;
          }
          75%{
              color: #81f5ff;
          }
          80%{
              color: #fe346e;
          }
          85%{
              color: #ffa41b;
          }
          90%{
              color: #fd2eb3;
          }
          95%{
              color: #40e0d0;
          }
}

        </style>
    </head>
    <body>
        <section class="forms-section">
        <h1 class="section-title rainbow">Database Operation</h1>
        <div class="forms">
          <div class="form-wrapper is-active">
            <button type="button" class="switcher switcher-login ">
              Login
              <span class="underline"></span>
            </button>
            <form class="form form-login" action="dashboard" method="POST">
              <fieldset>
                <legend>Please, enter your username and password for login.</legend>
                <div class="input-block">
                  <label for="login-email">Username</label>
                  <input id="login-email" type="text" name="user" required>
                </div>
                <div class="input-block">
                  <label for="login-password">Password</label>
                  <input id="login-password" type="password" name="pw" required>
                </div>
              </fieldset>
                <input type="submit" value="submit" class="btn-login"/>
            </form>
          </div>
          <div class="form-wrapper">
            <button type="button" class="switcher switcher-signup">
              Sign Up
              <span class="underline"></span>
            </button>
            <form class="form form-signup" action="register">
              <fieldset>
                <legend>Please, enter your username, password and password confirmation for sign up.</legend>
                <div class="input-block">
                  <label for="signup-name">Username</label>
                  <input id="signup-name" type="text" name="user" required>
                </div>
                <div class="input-block">
                  <label for="signup-password">Password</label>
                  <input id="signup-password" type="password" name="pw" required>
                </div>
                <div class="input-block">
                  <label for="signup-password-confirm">Confirm password</label>
                  <input id="signup-password-confirm" type="password" name="con_pw" required>
                </div>
              </fieldset>
                <input type="submit" value="sign up" class="btn-signup"/>
            </form>
          </div>
        </div>
        <script>
            const switchers = [...document.querySelectorAll('.switcher')]

            switchers.forEach(item => {
                    item.addEventListener('click', function() {
                            switchers.forEach(item => item.parentElement.classList.remove('is-active'))
                            this.parentElement.classList.add('is-active')
                    })
            })
            
            function confirmation(){
                var pw = document.getElementById("signup-password").value;
                var con_pw = document.getElementById("signup-password-confirm").value;
                
                if (pw !== con_pw) {
                    alert("Passwords don't match");
                }
            }
        </script>
      </section> 
    </body>
</html>
