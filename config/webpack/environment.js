import { environment } from '@rails/webpacker'
import { ProvidePlugin } from 'webpack'
environment.plugins.apeend('Provide',
  new ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    popper: ['popper.js', 'default']

  })
)
export default enviroment 