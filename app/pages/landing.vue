<template>
  <div class="login-reg-bg">
    <div class="log-reg-area sign" v-show="mode == 'login'">
      <h2 class="log-title">Login</h2>
      <form method="post" @submit.prevent="login">
        {{ error }}
        <div class="form-group">
          <input id="input_l_email" type="email" v-model="formInputs.email" required />
          <label class="control-label" for="input_l_email">Email</label><i class="mtrl-select"></i>
        </div>
        <div class="form-group">
          <input id="password_l_password" type="password" v-model="formInputs.password" required/>
          <label class="control-label" for="password_l_password">Password</label><i class="mtrl-select"></i>
        </div>
        <!-- <a href="#" title="" class="forgot-pwd">Forgot Password?</a> -->
        <div class="submit-btns">
          <button class="mtr-btn signin" type="submit"><span>Login</span></button>
          <button class="mtr-btn signup" type="button" @click.prevent="mode = 'register'"><span>Register</span></button>
        </div>
      </form>
    </div>
    <div class="log-reg-area reg" v-show="mode == 'register'">
      <h2 class="log-title">Register</h2>
      {{ error }}
      <form method="post" @submit.prevent="register">
        <div class="form-group">
          <input id="input_r_name" type="text" v-model="formInputs.name" required />
          <label class="control-label" for="input_r_name">Name</label><i class="mtrl-select"></i>
        </div>
         <div class="form-group">
          <input id="input_r_email" type="email" v-model="formInputs.email" required />
          <label class="control-label" for="input_r_email">Email</label><i class="mtrl-select"></i>
        </div>
         <div class="form-group">
          <input id="input_r_username" type="text" v-model="formInputs.username" required />
          <label class="control-label" for="input_r_username">Username</label><i class="mtrl-select"></i>
        </div>
         <div class="form-group">
          <input id="input_r_password" type="password" v-model="formInputs.register_password" required />
          <label class="control-label" for="input_r_password">Password</label><i class="mtrl-select"></i>
        </div>
        <div class="checkbox">
          <label>
            <input type="checkbox" v-model="formInputs.tos" /><i class="check-box"></i>Accept Terms & Conditions ?
          </label>
        </div>
        <a href="#" title="" class="already-have" @click.prevent="mode = 'login'">Already have an account</a>
        <div class="submit-btns">
          <button class="mtr-btn signup" type="submit" :disabled="isRegisterDisabled"><span>Register</span></button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { useContext, computed } from '@nuxtjs/composition-api';

  const { $auth, $axios } = useContext();


  const defaultFormInputs = {
    email: '',
    name: '',
    username: '',
    password: '',
    register_password: '',
    tos: '',
  }

  let formInputs = $ref({
    ...defaultFormInputs
  })

  const resetForm = () => {
    formInputs = {
      ...defaultFormInputs
    };
  }

  let error = $ref('');
  let mode = $ref('login');

  const isRegisterDisabled = computed(() =>
    !formInputs.tos
    || !formInputs.name
    || !formInputs.username
    || !formInputs.register_password
  );

  const login = () => {
    $auth.login({
      data: {
        user: {
          email: formInputs.email,
          password: formInputs.password
        }
      }
    })
    .catch(e => { error = e.response.data.error })
  }

  const register = async () => {
    await $axios.post('/users/', {
        user: {
          email: formInputs.email,
          name: formInputs.name,
          username: formInputs.username,
          password: formInputs.register_password
        }
    })
    .catch(e => { error = e.response.data.error });

    $auth.login({
      data: {
        user: {
          email: formInputs.email,
          password: formInputs.register_password
        }
      }
    })
    .catch(e => { error = e.response.data.error })
  }
</script>

<script lang="ts">
  export default {
    layout: 'auth',
  }
</script>
