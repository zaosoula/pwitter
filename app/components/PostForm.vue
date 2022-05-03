<template>
  <div class="new-postbox">
    <figure>
      <img :src="profilePicture" alt="">
    </figure>
    <div class="newpst-input">
      <form method="post" @submit.prevent="handleSubmit">
        <textarea rows="2" placeholder="write something" v-model="formInputs.content"></textarea>
        <div class="attachments">
          <ul>
            <!-- <li>
              <i class="fa fa-music"></i>
              <label class="fileContainer">
                <input type="file">
              </label>
            </li>
            <li>
              <i class="fa fa-image"></i>
              <label class="fileContainer">
                <input type="file">
              </label>
            </li>
            <li>
              <i class="fa fa-video-camera"></i>
              <label class="fileContainer">
                <input type="file">
              </label>
            </li>
            <li>
              <i class="fa fa-camera"></i>
              <label class="fileContainer">
                <input type="file">
              </label>
            </li> -->
            <li>
              <button type="submit">Post</button>
            </li>
          </ul>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { useProfilePicture } from '~/hooks/profilePicture';
  import { useContext } from '@nuxtjs/composition-api';

  const emit = defineEmits(['submit']);
  const props = defineProps<{
    defaultContent?: string;
  }>();

  const { $axios, $swal } = useContext();
  const profilePicture = useProfilePicture();

  const defaultFormInputs = {
    content: `${props.defaultContent} ` || '',
  }

  let formInputs = $ref({
    ...defaultFormInputs
  })

  const resetForm = () => {
    formInputs = {
      ...defaultFormInputs
    };
  }

  const handleSubmit = async () => {
    const response = await $axios.post('/posts', formInputs);


    if(response.status !== 201) {
      return $swal('An unexpected error occured');
    }

    emit('submit', {values: formInputs, response});
    resetForm();

  }
</script>
