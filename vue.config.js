const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  lintOnSave: false, // Prevents ESLint errors from failing the build
  publicPath: process.env.NODE_ENV === 'production'
    ? '/pesky-box-vue/' // Replace 'pesky-box-vue' with your actual repository name if different
    : '/'
})
