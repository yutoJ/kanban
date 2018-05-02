/*jshint esversion: 6 */

require.context('../images', true, /\.(png|jpg|jpeg|svg)$/);

import '../stylesheets/application';
import 'bootstrap/dist/js/bootstrap';
import 'expose-loader?$!jquery';
import 'moment/locale/ja';
import 'bootstrap4-datetimepicker/build/js/bootstrap-datetimepicker.min';
import './image_preview';
import './date_picker';

import Rails from 'rails-ujs';
Rails.start();
