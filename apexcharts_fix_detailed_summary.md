# ApexCharts表示問題 詳細解決レポート

## 1. 問題の背景と初期状態

### 問題点
- ApexChartsがビューに表示されない
- ブラウザの検証ツールでapplication.jsが読み込まれているが、ソースに表示されない
- コンソールエラーが発生

### 初期エラー内容
```
Uncaught TypeError: Failed to resolve module specifier "@hotwired/turbo-rails"
```

## 2. 問題解決のアプローチ

### 2.1 Stimulusコントローラーの導入

#### 目的
- インラインスクリプトを排除し、モジュール化
- Turboとの互換性を確保
- コードの再利用性向上

#### 実装内容
```javascript
import { Controller } from "@hotwired/stimulus"
import ApexCharts from "apexcharts"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    const options = {
      chart: { type: 'line', height: 350 },
      series: [{ name: 'Sales', data: [30, 40, 35, 50, 49, 60, 70, 91, 125] }],
      xaxis: { categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'] }
    }

    this.chart = new ApexCharts(this.containerTarget, options)
    this.chart.render()
  }

  disconnect() {
    if (this.chart) {
      this.chart.destroy()
    }
  }
}
```

### 2.2 ビューのリファクタリング

#### 変更点
- data-controller属性を追加
- data-target属性を使用
- インラインスクリプトを削除

```erb
<div class="container mx-auto p-4" data-controller="chart">
  <h1 class="text-2xl font-bold mb-4">ApexCharts Sample</h1>
  <div class="bg-white rounded-lg shadow p-6">
    <div id="chart" data-chart-target="container"></div>
  </div>
</div>
```

### 2.3 application.jsの修正

#### 発生したエラー
```
Could not resolve "./node_modules/@hotwired/turbo-rails/dist/turbo.es2017-esm.js"
```

#### 解決策
- モジュール解決方法を変更
- パッケージ名直接指定に変更

```javascript
import { Turbo } from "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import ApexCharts from "apexcharts"
import ChartController from './controllers/chart_controller'

window.Turbo = Turbo;
window.ApexCharts = ApexCharts;

const application = Application.start();
application.register('chart', ChartController);
```

### 2.4 esbuild設定の調整

#### 問題点
- 外部モジュールの解決に失敗
- ビルドエラーが発生

#### 修正内容
- package.jsonのビルドスクリプトから--externalオプションを削除
- モジュールバンドリングを適切に設定

```json
"scripts": {
  "build": "esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=/assets --format=esm",
  "build:watch": "esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=/assets --format=esm --watch"
}
```

## 3. 技術的な選択理由

### Stimulusを選んだ理由
- Turboとの親和性が高い
- 軽量でシンプルな実装が可能
- Railsのエコシステムに適合

### esbuildの利点
- 高速なビルド
- モダンなJavaScriptのサポート
- 設定がシンプル

## 4. 学びと今後の改善点

### 得られた知見
- jsbundling-railsの適切な使用方法
- Stimulusコントローラーの設計パターン
- esbuildの設定方法

### 今後の改善
- テストの追加
- エラーハンドリングの強化
- 設定のドキュメント化
