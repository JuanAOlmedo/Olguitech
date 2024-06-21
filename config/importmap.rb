# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin 'trix-editor-overrides'
pin 'webp'
pin_all_from 'app/javascript/controllers', under: 'controllers'

pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin 'trix', to: 'https://ga.jspm.io/npm:trix@2.1.1/dist/trix.esm.min.js', preload: false
pin '@rails/actiontext', to: '@rails--actiontext.js', preload: false # @7.1.3
