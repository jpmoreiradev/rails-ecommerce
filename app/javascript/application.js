// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as ActiveStorage from "@rails/activestorage"
import "@rails/request.js"  // necessário para method: :delete
import "@rails/ujs"         // se estiver usando UJS
