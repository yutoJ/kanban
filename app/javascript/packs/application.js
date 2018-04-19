/*jshint esversion: 6 */

require.context('../images', true, /\.(png|jpg|jpeg|svg)$/);

import '../stylesheets/application';
import 'bootstrap/dist/js/bootstrap';
import './image_preview';
import 'expose-loader?$!jquery';

import Rails from 'rails-ujs';
Rails.start();
