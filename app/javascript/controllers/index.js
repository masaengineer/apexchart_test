// Import and register all your controllers from the importmap under controllers/*

import ThemeController from './theme_controller';

export function registerControllers(application) {
  application.register('theme', ThemeController);
}
