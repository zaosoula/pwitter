<template>
  <div class="login-reg-bg">
    <div class="log-reg-area sign">
      <h2 class="log-title">Login</h2>
      <p>
        Don’t use Winku Yet? <a href="#" title="">Take the tour</a> or <a href="#" title="">Join now</a>
      </p>
      <form method="post" @submit.prevent="login">
        {{ error }}
        <div class="form-group">
          <input id="input" type="email" v-model="email" required />
          <label class="control-label" for="input">Email</label><i class="mtrl-select"></i>
        </div>
        <div class="form-group">
          <input type="password" v-model="password" required/>
          <label class="control-label" for="input">Password</label><i class="mtrl-select"></i>
        </div>
        <a href="#" title="" class="forgot-pwd">Forgot Password?</a>
        <div class="submit-btns">
          <button class="mtr-btn signin" type="submit"><span>Login</span></button>
          <button class="mtr-btn signup" type="button" disabled><span>Register</span></button>
        </div>
      </form>
    </div>
    <div class="log-reg-area reg">
      <h2 class="log-title">Register</h2>
      <p>
        Don’t use Winku Yet? <a href="#" title="">Take the tour</a> or <a href="#" title="">Join now</a>
      </p>
      <form method="post">
        <div class="form-group">
          <input type="text" required="required" />
          <label class="control-label" for="input">First & Last Name</label><i class="mtrl-select"></i>
        </div>
        <div class="form-group">
          <input type="text" required="required" />
          <label class="control-label" for="input">User Name</label><i class="mtrl-select"></i>
        </div>
        <div class="form-group">
          <input type="password" required="required" />
          <label class="control-label" for="input">Password</label><i class="mtrl-select"></i>
        </div>
        <div class="form-radio">
          <div class="radio">
            <label>
              <input type="radio" name="radio" checked="checked" /><i class="check-box"></i>Male
            </label>
          </div>
          <div class="radio">
            <label>
              <input type="radio" name="radio" /><i class="check-box"></i>Female
            </label>
          </div>
        </div>
        <div class="form-group">
          <input type="text" required="required" />
          <label class="control-label" for="input"><a href="https://wpkixx.com/cdn-cgi/l/email-protection"
              class="__cf_email__" data-cfemail="6c29010d05002c">[email&#160;protected]</a></label><i
            class="mtrl-select"></i>
        </div>
        <div class="checkbox">
          <label>
            <input type="checkbox" checked="checked" /><i class="check-box"></i>Accept Terms & Conditions ?
          </label>
        </div>
        <a href="#" title="" class="already-have">Already have an account</a>
        <div class="submit-btns">
          <button class="mtr-btn signup" type="button"><span>Register</span></button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { useContext, useRouter } from '@nuxtjs/composition-api';

  const { $auth } = useContext();

  let email = $ref<string>('');
  let password = $ref<string>('');
  let error = $ref<string>('');

  const login = () => {
    $auth.login({
      data: {
        user: {
          email,
          password
        }
      }
    })
    .catch(e => { error = e.response.data.error })
  }
</script>

<script lang="ts">
  export default {
    layout: 'auth',
    // auth: 'guest'
  }
</script>
