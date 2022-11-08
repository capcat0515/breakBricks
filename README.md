# 打磚塊
### 大三上的互動技術概論之期末專案(2018/09~2019/01)

這專案Processing+arduion做搭配

Processing為遊戲設計  Arduion加入按鈕與搖桿

* 開始畫面
  * 中間三角形為開始按鈕
  * 右上角的齒輪為進入設定按鈕
  
* 遊戲

  遊戲規則: 每幾秒會生成磚塊會往地面掉落，需要用地面的球打掉，直到磚塊接觸地上(下面黃色的線)，遊戲結束
  
  磚塊: 第一層磚塊打擊一次就消失，第二層打擊兩次，以此類堆。磚塊位置與數量在同層是隨機。
  
  發射台: 有個紅色一個瞄準線，調整轉盤可調整發射方向(有角度限制)，搖桿的X軸是調整發射台X軸的位置。
  
  發射: 按下Arduion接的按鈕。
  

* 設定
  * 音樂聲音，初始是50，範圍0~100
  * 發射球的速度，初始是10，範圍5~15

* 得分排行欄 
  * 紀錄得分前五名高的玩家
  
  如果想離開，就搖桿的X軸往左，並按下按鈕，就遊戲結束
  如果想在玩，就搖桿的X軸往右，並按下按鈕，就遊戲重新開始

| 開始畫面 | 遊戲 | 設定 | 得分排行欄 |
|:-------:|:----:|:----:|:-----:|
|  ![](https://github.com/capcat0515/breakBricks/blob/main/images/%E6%89%93%E7%A3%9A%E5%A1%8A_start.png)  |  ![](https://github.com/capcat0515/breakBricks/blob/main/images/%E6%89%93%E7%A3%9A%E5%A1%8A_play.png)  | ![](https://github.com/capcat0515/breakBricks/blob/main/images/%E6%89%93%E7%A3%9A%E5%A1%8A_setting.png)  | ![](https://github.com/capcat0515/breakBricks/blob/main/images/%E6%89%93%E7%A3%9A%E5%A1%8A_pointColumn.png)  |
