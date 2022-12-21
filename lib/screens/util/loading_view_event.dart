enum LoadingViewEvent{
  loading,
  // 顯示loading, 且禁止碰觸事件 (僅限當前的畫面, 無阻擋外層的碰觸事件)
  loadingDisableTouch,
  idle,
  notShowLoading
}
