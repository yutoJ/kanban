/*jshint esversion: 6 */

require.context('../images', true, /\.(png|jpg|jpeg|svg)$/);

import '../stylesheets/application';
import 'bootstrap/dist/js/bootstrap';
import 'expose-loader?$!jquery';

import Rails from 'rails-ujs';
Rails.start();
