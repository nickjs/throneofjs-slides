!SLIDE[tpl=image]
# easy* url routing #
- - -
- - -

	@@@ coffeescript
	class Shopify extends Batman.App
		@resources 'products'
		@route 'search', 'search#index'

	class Shopify.ProductsController extends Batman.Controller
		index: ->
			@products = Shopify.Product.get 'all'

		show: (params) ->
			@product = Shopify.Product.find params.id
- - -
	@@@ html
	<a data-route="routes.products.index">Products</a>

<h2 style="margin-top:150px"> *if you're following conventions </h2>

.notes foo

!SLIDE
# "But Sir Nicholas III, what if I want to route #
	my-Stupid#u_r-L
# to a Jabber XML WebDAV node server?" #

!SLIDE[tpl=image]
![facepalm](double-facepalm.jpg)

.notes Either use a different framework, or put your files where the files go.


!SLIDE[tpl=image]
# easy* persistence #
- - -
- - -

	@@@ coffeescript
	class Shopify.Product extends Batman.Model
		@persist Batman.RestStorage
		@validate 'name', presence: true

<h2 style="margin-top:200px"> *if you're following conventions </h2>

.notes As long as your models use the built in namespaces and a Rails-like JSON encoding, this will work right out of the box.
INCLUDING

!SLIDE[tpl=image]
# easy* associations #
- - -
- - -

	@@@ coffeescript
	class Shopify.Product extends Batman.Model
		@persist Batman.RestStorage

		@hasMany 'images'
		@belongsTo 'order'

<h2 style="margin-top:200px"> *if you're following conventions </h2>

.notes Now this is pretty cool stuff. Your associations client side will mirror those server side.
If the data comes in from your backend with the associations inline, batman will put them right into the identity map.
If they don't, batman will lazy load them, in this case the product image, when you request them.
It even automatically builds the association URL, if you're following conventions.
There's a lot of other nice stuff in our model API too, like easy pagination and filtering, and polymorphic associations.

!SLIDE[tpl=bindings]
# html bindings #
- - -
- - -

	@@@ html
	<div data-bind="conference.name"></div>

<h2 data-bind="conference.name"></h2>

<div class="bindings">
	conference.name: <input data-bind="conference.name" />
</div>

!SLIDE[tpl=bindings]
# html bindings #
- - -
- - -

	@@@ html
	<h2>
		This conference is <span class="label"
			data-addclass-success="conference.isAwesome">
		<span data-showif="conference.isAwesome">AWESOME</span>
		<span data-hideif="conference.isAwesome">LAME</span>
		</span>
	</h2>

<h2>
	This conference is <span class="label" data-addclass-label-success="conference.isAwesome">
	<span data-showif="conference.isAwesome">AWESOME</span>
	<span data-hideif="conference.isAwesome">LAME</span>
	</span>
</h2>

<div class="bindings">
	<label for="confIsAwesome"><strong>conference.isAwesome:</strong>
		<input type="checkbox" data-bind="conference.isAwesome" name="confIsAwesome" />
	</label>
</div>

!SLIDE[tpl=bindings]
# html bindings #
- - -
- - -

	@@@ html
	<ul>
		<li data-foreach-framework="conference.frameworks">
			<span
				data-bind="framework.name | default 'new'">
			</span>
		</li>
	</ul>

<ul>
	<li data-foreach-framework="conference.frameworks">
		<span data-bind="framework.name | default 'new'"></span>
	</li>
</ul>

<div class="bindings">
	<ul>
		<li data-foreach-framework="conference.frameworks">
			<span data-bind="framework.name | default 'new framework'"></span>:
			<input data-bind="framework.name" placeholder="Enter a framework name" />
		</li>
	</ul>

	<button class="btn" data-event-click="layout.addFramework">add</button>
</div>

!SLIDE[tpl=image]
# partials #
- - -
- - -

	@@@ html
	<div data-partial="products/inventory"></div>

- - -
views/products/inventory.html:
- - -

	@@@ html
	<div class="product-inventory">
		<span data-bind="product.name | capitalize"></span>
		<input data-bind="product.inventoryCount" />
	</div>

.notes And the great thing is you still have access to the outer scope inside of the partial.
Shiny.

!SLIDE[tpl=image]
## there hasn't been a stock photo in a while ##
![meeting](meeting.jpg)

!SLIDE
## using data bindings is great if: ##

* you want to avoid a loading screen
* you have a designer who wants to be able to add functionality to her designs
* you have existing html you want to modernize
* you want to use jQuery et. al to update the document

.quote -1

.notes By not having to translate your template string into a document fragment, the HTML is ready to go from the get go and can be shown immediately. Including to search engines!
It really becomes feasible for designers to play a larger role in wiring up their designs without having to learn an entirely new language. They simply add HTML properties.
Finally, if you are using something like jQuery to style your document, certain template languages will need to through out the whole document fragment when there's an update.
Even though most modern ones are really smart about not doing that, data bindings alleviate the need for it completely.

!SLIDE
## using data bindings is horrible if: ##

* you hate html
* you want to mix _very_ complex logic into your presentation layer
