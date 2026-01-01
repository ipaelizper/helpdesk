<template>
  <v-container fluid class="fill-height my-8">
    <v-row align="center" justify="center" class="fill-height">
      <v-col cols="12" sm="10" md="8" lg="6" xl="5">
        <v-card class="elevation-12 rounded-xl overflow-hidden">
          <v-card-title class="text-h5 font-weight-bold text-center pa-10 primary">
            Helpdesk Login
          </v-card-title>

          <v-card-text class="pa-10 pb-12">
            <v-form ref="form" v-model="valid" @submit.prevent="login">
              <v-text-field v-model="email" label="Email" type="email" prepend-inner-icon="mdi-email-outline"
                variant="outlined" density="comfortable" :rules="[rules.required, rules.email]" required
                autofocus></v-text-field>

              <v-text-field v-model="password" label="Password" type="password" prepend-inner-icon="mdi-lock-outline"
                variant="outlined" density="comfortable" :rules="[rules.required]" required class="mt-6"></v-text-field>

              <v-btn type="submit" color="primary" block size="large" class="mt-10" :loading="loading"
                :disabled="!valid || loading">
                Login
              </v-btn>

              <v-alert v-if="error" type="error" density="compact" class="mt-8" icon="mdi-alert-circle">
                {{ error }}
              </v-alert>
            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import api from '@/plugins/axios'


const router = useRouter()
const valid = ref(false)
const loading = ref(false)
const error = ref('')

const email = ref('')
const password = ref('')

const rules = {
  required: (v) => !!v || 'This field is required',
  email: (v) => /.+@.+\..+/.test(v) || 'Invalid email format',
}

const login = async () => {
  if (!valid.value) return

  loading.value = true
  error.value = ''

  try {
    const res = await api.post('/login', {
      email: email.value,
      password: password.value,
    })

    localStorage.setItem('token', res.data.token)
    localStorage.setItem('user', JSON.stringify(res.data.user))

    router.push('/tickets')
  } catch (err) {
    error.value = err.response?.data?.message || 'Login failed'
  } finally {
    loading.value = false
  }
}
</script>
