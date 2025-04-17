const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  lintOnSave: false, // Prevents ESLint errors from failing the build
  publicPath: process.env.NODE_ENV === 'production'
    ? '/' + process.env.REPOSITORY_NAME + '/'
    : '/'
})
