class Throne.LayoutView extends Batman.View
	quoteIndex: 0
	@accessor 'quote', ->
		Throne.quotes[@get 'quoteIndex']
	updateQuoteIndex: ($node) ->
		index = parseInt $node.find('.quote').text()
		if index is -1
			$node.find('.quote-index').hide()
		else if isNaN index
			index = Math.floor(Math.random() * Throne.quotes.length - 1)

		@set 'quoteIndex',  index

	setQuote: (quote) ->
		@set 'quoteIndex', Throne.quotes.indexOf quote

	showSlide: ($slide) ->
		@updateQuoteIndex $slide

		bindings = $slide.find('.bindings').hide()
		if bindings.length
			$slide.find('pre').css('cursor', 'pointer').click =>
				$('#changeBindings').modal backdrop: false, show: true
				$('#changeBindings').find('.modal-body').html('').append(bindings.show())
				@hideBindings = ->
					$slide.append(bindings.hide())

	addFramework: =>
		@get('conference.frameworks').add new Batman.Object

	ready: ->
		$(document.body).tooltip selector: '[rel=tooltip]'
		$('#changeBindings').on 'hide', => @hideBindings()

	constructor: ->
		super
		frameworks = new Batman.Set
		frameworks.add new Batman.Object name: 'batman'
		frameworks.add new Batman.Object name: 'backbone'
		@set 'conference', new Batman.Object
			name: "Throne of Java"
			frameworks: frameworks

