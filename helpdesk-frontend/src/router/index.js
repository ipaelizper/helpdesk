import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue'),
    meta: { requiresAuth: false },
  },
  {
    path: '/',
    redirect: '/tickets',
  },
  {
    path: '/tickets',
    name: 'TicketList',
    component: () => import('../views/TicketList.vue'),
    meta: { requiresAuth: true },
  },
  {
    path: '/tickets/create',
    name: 'TicketCreate',
    component: () => import('../views/TicketCreate.vue'),
    meta: { requiresAuth: true },
  },
  {
    path: '/tickets/:id',
    name: 'TicketDetail',
    component: () => import('../views/TicketDetail.vue'),
    meta: { requiresAuth: true },
  },

  { path: '/:pathMatch(.*)*', redirect: '/tickets' },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

// Navigation Guard
router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')
  const isAuthenticated = !!token

  // ถ้าไปหน้า login แต่มี token อยู่แล้ว → redirect ไป tickets
  if (to.path === '/login' && isAuthenticated) {
    next('/tickets')
    return
  }

  // ถ้าไปหน้าที่ต้อง auth แต่ไม่มี token → ไป login
  if (to.meta.requiresAuth && !isAuthenticated) {
    next('/login')
  } else {
    next()
  }
})


export default router
