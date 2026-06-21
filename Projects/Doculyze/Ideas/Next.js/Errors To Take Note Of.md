
# 

# Nested Divs
A <div> element or Component cannot be placed outside of the <body> tag.
The only permitted direct children of an <html> tag are <head> and<body>.

When I placed my <Header> component inside the <RootLayout>, I accidentally placed it underneath <html> and above <head>.

Furthermore, I found out that placing <Header> beneath `{children}` causes my header to become a footer. So, the solution was to place <Header> on top of children inside <body>.

<html>
	<head>
		<body>
			<Header></Header>
			{children}
		</body>
	</head>
</html>
