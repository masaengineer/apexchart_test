import { Controller } from '@hotwired/stimulus';

// テーマ切り替えを管理するコントローラー
export default class extends Controller {
  connect() {
    // ローカルストレージからテーマを取得
    const theme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', theme);

    // テーマ切り替えボタンの状態を設定
    const themeController = document.querySelector('.theme-controller');
    if (themeController) {
      themeController.checked = theme === 'dark';
    }

    // テーマ切り替えイベントのリスナーを設定
    themeController?.addEventListener('change', (e) => {
      const newTheme = e.target.checked ? 'dark' : 'light';
      document.documentElement.setAttribute('data-theme', newTheme);
      localStorage.setItem('theme', newTheme);
    });
  }
}
