const { environment } = require('@rails/webpacker')
const DashboardPlugin = require('webpack-dashboard/plugin')
const webpack = require('webpack')

const config = Object.assign({}, environment.toWebpackConfig(), {
  module: {
    rules: [
      {
        test: /\.(js|jsx)?(\.erb)?$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        options: { cacheDirectory: 'tmp/cache/webpacker/babel-loader' }
      }
    ]
  },
  devtool: process.env.RAILS_ENV === 'development' ? 'cheap-module-eval-source-map' : 'eval'
})

config.plugins.push(new webpack.NamedModulesPlugin())
config.plugins.push(new DashboardPlugin())

module.exports = config
