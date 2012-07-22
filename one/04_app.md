!SLIDE commandline incremental
# some tools #
- - -

	$ batman new my_app
	INFO: creating /Users/Nick/Code/Talks/my_app/resources/batman.png
	INFO: creating /Users/Nick/Code/Talks/my_app/index.html
	INFO: creating /Users/Nick/Code/Talks/my_app/my_app.coffee
	INFO: creating /Users/Nick/Code/Talks/my_app/package.json
	INFO: creating /Users/Nick/Code/Talks/my_app/controllers/application_controller.coffee
	INFO: creating /Users/Nick/Code/Talks/my_app/controllers/examples_controller.coffee
	INFO: creating /Users/Nick/Code/Talks/my_app/views/examples/index.html
	INFO: creating /Users/Nick/Code/Talks/my_app/README
	OK: my_app generated successfully.

!SLIDE commandline incremental
# some tools #
- - -

	$ batman gen controller products
	INFO: creating /Users/Nick/Code/Talks/my_app/controllers/products_controller.coffee
	OK: products generated successfully.

	$ batman gen model product
	INFO: creating /Users/Nick/Code/Talks/my_app/models/product.coffee
	OK: product generated successfully.

!SLIDE
## my_app.coffee ##

	@@@ coffeescript
	class MyApp extends Batman.App
		@resources 'products'
		@root 'products#index'

	# Make MyApp available in the global namespace so it can be used
	# as a namespace and bound to in views.
	window.MyApp = MyApp

!SLIDE
## controllers/products_controller.coffee ##

	@@@ coffeescript
	class MyApp.ProductsController extends Batman.Controller
	routingKey: 'products'
		index: (params) ->
			@products = MyApp.Product.get 'all'

		new: (params) ->
			@product = new MyApp.Product

		create: ->
			@product.save()
			@redirect '/'

!SLIDE
## models/product.coffee ##

	@@@ coffeescript
	class MyApp.Product extends Batman.Model
		@resourceName: 'product'
		@persist Batman.RestStorage

		@encode 'name'
		@validate 'name', presence: true

		@hasMany 'tags'

!SLIDE
## views/products/index.html ##

	@@@ html
	<table>
		<tr data-foreach-product="products">
			<td data-bind="product.name"></td>
		</tr>
	</table>

	<a data-route="routes.products.new">New Product</a>

!SLIDE
## views/products/new.html ##

	@@@ html
	<form data-formfor-product="product" data-event-submit="create">
		<div>Name: <input type="text" data-bind="product.name" /></div><br />
		<div><input type="submit"></div>
	</form>
