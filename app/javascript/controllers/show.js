import { Application } from '@hotwired/stimulus'
import Carousel from 'stimulus-carousel'

const application = Application.start()
application.register('carousel', Carousel)
