<script>
export default {
  props: {
    user: {
      type: Object,
      default: {},
    },
  },
  setup(props) {
    return {
    };
  },
};
</script>

<template>
  <div class="user-panel-wrapper">
    <div class="user-info">
      <div class="flex-center">
        <div class="user-image">
          <img :src="user.Avatar" class="img-center round" />
        </div>
      </div>

      <div class="m-mt16 m-mb16">
        <div class="user-name m-mb4 text-center">
          <div class="text-large">{{ user.FullName }}</div>
        </div>

        <div class="user-email">
          <div class="text-small text-center">{{ user.Email }}</div>
        </div>
      </div>
    </div>

    <div class="user-control line">
      <div class="btn-user-control">
        <div class="mi-change-password"></div>
        <div class="">Đổi mật khẩu</div>
      </div>

      <div class="btn-user-control">
        <div class="mi-change-info"></div>
        <div class="">Thiết lập tài khoản</div>
      </div>
    </div>

    <div class="logout line flex-center m-pt8 m-pb8 pointer">
      <div class="btn-user-control">
        <div class="mi-logout"></div>
        <div class="m-ml8">Đăng xuất</div>
      </div>
    </div>
  </div>
</template>

<style>
.user-panel-wrapper {
  width: 302px;
}

.user-panel-wrapper .user-info {
  padding: 24px 16px 0 16px;
}

.user-panel-wrapper .user-info .user-image {
  width: 64px;
  height: 64px;
  border-radius: 50%;
}

.user-panel-wrapper .user-info .user-email .text-small {
  color: #666666 !important;
}

.user-panel-wrapper .user-control {
  padding: 8px 16px;
}

.user-panel-wrapper .btn-user-control {
  display: flex;
  align-items: center;
  cursor: pointer;
}

.user-panel-wrapper .btn-user-control:hover, .user-panel-wrapper .logout:hover {
  background-color: #f2f2f2;
}

</style>
