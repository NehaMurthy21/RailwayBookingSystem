<!DOCTYPE html>
<html>
<head>
    <style type="text/css">
        h1 {
            font-size: 40px;
            color: #004080;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .form-label {
            font-size: 30px;
            font-weight: bold;
        }
        .radio-option {
            font-size: 30px;
        }
        .input-field {
            font-size: 25px;
            padding: 8px;
            width: 200px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            font-size: 16px;
            font-weight: bold;
            padding: 10px 15px;
            background-color: #0073e6;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #005bb5;
        }
        input[type="radio"] {
            transform: scale(1.5);
            margin-right: 8px;
        }
        .radio-option {
            font-size: 35px;
        }
    </style>
    <meta charset="UTF-8">
    <title>Login Page</title>
</head>
<body>

<h1>Login</h1>
<br>
		<form method="get" action="actionLogin.jsp">
		  
			<table>
			
			<br>
			
				<tr>  
					<td class="form-label">Username: </td><td><input type="text" name="username" class="input-field"></td>
				</tr>
				<br>
				<tr>
					<td class="form-label">Password: </td><td><input type="password" name="password" class="input-field"></td>
				</tr>
				
			</table>
			<br>
			
			<input type="submit" value="Login">
		</form>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>

   
</body>
</html>