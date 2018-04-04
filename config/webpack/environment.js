const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.set(
  'Provide',
  new webpack.ProvidePlugin({
    jQuery: 'jquery/dist/jquery',
    Popper: 'popper.js/dist/popper'
  })
)

environment.loaders.get('sass').use.splice(-1, 0, {
  loader: 'resolve-url-loader'
});

module.exports = environment
