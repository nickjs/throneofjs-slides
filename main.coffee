#= require batman/batman
#= require batman/batman.jquery

#= require_self
#= require quotes
#= require_tree ./views

class Throne extends Batman.App
	@layout: 'layout'

Batman.ViewStore.prefix = 'assets/views'

window.Throne = Throne
Throne.navigator = new Batman.Navigator
$ ->
	$('.content').live 'showoff:show', (e) =>
		@currentSlide = $(e.target)
		Throne.layout?.showSlide? @currentSlide
	$('#preso').bind 'showoff:loaded', =>
		Throne.run()
		Throne.layout.showSlide @currentSlide
