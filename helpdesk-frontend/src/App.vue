<template>
  <v-app theme="dark">
    <!-- Header / App Bar -->
    <v-app-bar app color="surface" flat>
      <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>

      <v-toolbar-title class="ml-2 font-weight-bold">Helpdesk</v-toolbar-title>

      <v-spacer></v-spacer>


      <v-menu offset-y left nudge-bottom="10">
        <template v-slot:activator="{ props }">
          <v-btn icon v-bind="props">
            <v-avatar color="primary" size="40">
              <v-icon v-if="!userName" size="24">mdi-account</v-icon>
              <span v-else class="white--text text-h6">{{ userInitials }}</span>
            </v-avatar>
          </v-btn>
        </template>

        <v-list>
          <v-list-item>
            <v-list-item-title>{{ userName || 'Guest' }}</v-list-item-title>
          </v-list-item>
          <v-list-item @click="logout">
            <v-list-item-title>Logout</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>

    <!-- Navigation Drawer -->
    <v-navigation-drawer v-model="drawer" app color="background" rail permanent class="elevation-2">
      <v-list nav>
        <v-list-item v-for="item in menuItems" :key="item.to"
          :to="item.to"
          :active="item.active"
          >
          <template v-slot:prepend>
            <v-icon>{{ item.icon }}</v-icon>
          </template>
          <v-list-item-title>{{ item.title }}</v-list-item-title>
        </v-list-item>
      </v-list>

      <template v-slot:append>
        <div class="pa-4 text-center">
          <v-tooltip location="top">
            <template v-slot:activator="{ props }">
              <v-btn icon color="error" variant="text" v-bind="props" @click="logout">
                <v-icon size="28">mdi-logout</v-icon>
              </v-btn>
            </template>
            <span>Logout</span>
          </v-tooltip>
        </div>
      </template>
    </v-navigation-drawer>

    <v-main>
      <v-container fluid class="pa-0">
        <router-view></router-view>
      </v-container>
    </v-main>
  </v-app>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const drawer = ref(true)

const userName = ref('')
const userInitials = computed(() => {
  if (!userName.value) return '' // จะใช้ไอคอนแทน
  const names = userName.value.trim().split(' ')
  if (names.length >= 2) {
    return (names[0][0] + names[1][0]).toUpperCase()
  }
  return userName.value.substring(0, 2).toUpperCase()
})

onMounted(() => {
  const storedUser = localStorage.getItem('user')
  if (storedUser) {
    const user = JSON.parse(storedUser)
    userName.value = user.name || ''
  }
})

const logout = () => {
  localStorage.removeItem('token')
  localStorage.removeItem('user')
  router.push('/login')
}

const menuItems = ref([
  { title: 'Tickets', icon: 'mdi-ticket-confirmation', to: '/tickets' },
])
</script>
