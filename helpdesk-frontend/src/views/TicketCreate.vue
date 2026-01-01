<template>
  <v-container fluid class="pa-6">
    <v-card max-width="900" class="mx-auto" elevation="6">
      <v-card-title class="text-h5 primary white--text py-6">
        Create New Ticket
      </v-card-title>

      <v-card-text>
        <v-form ref="formRef" v-model="valid" @submit.prevent="createTicket">
          <!-- Title -->
          <v-text-field
            v-model="form.title"
            label="Title *"
            prepend-inner-icon="mdi-text"
            :rules="[rules.required]"
            variant="outlined"
            required
          />

          <!-- Description -->
          <v-textarea
            v-model="form.description"
            label="Description *"
            rows="5"
            auto-grow
            prepend-inner-icon="mdi-note-text"
            :rules="[rules.required]"
            variant="outlined"
            required
          />

          <!-- Contact & Cc Email -->
          <v-row>
            <v-col cols="12" md="6">
              <v-text-field
                v-model="form.contact_email"
                label="Contact Email *"
                type="email"
                prepend-inner-icon="mdi-email"
                :rules="[rules.required, rules.email]"
                variant="outlined"
                required
              />
            </v-col>

            <v-col cols="12" md="6">
              <v-text-field
                v-model="form.cc_email"
                label="Cc Email (optional)"
                type="email"
                prepend-inner-icon="mdi-email-plus"
                variant="outlined"
              />
            </v-col>
          </v-row>

          <!-- Priority -->
          <v-select
            v-model="form.priority"
            :items="priorities"
            label="Priority *"
            prepend-inner-icon="mdi-alert"
            :rules="[rules.required]"
            variant="outlined"
            required
          />

          <!-- Category (New) -->
          <v-select
            v-model="form.category"
            :items="categories"
            label="Category (optional)"
            prepend-inner-icon="mdi-tag-outline"
            variant="outlined"
            clearable
          />

          <!-- Status (New) -->
          <v-select
            v-model="form.status"
            :items="statuses"
            label="Status (default: Open)"
            prepend-inner-icon="mdi-checkbox-marked-circle-outline"
            variant="outlined"
            :color="statusColor"
            clearable
          />

          <!-- Organization -->
          <v-select
            v-model="form.organization_id"
            :items="organizations"
            item-title="name"
            item-value="id"
            label="Organization *"
            prepend-inner-icon="mdi-domain"
            :rules="[rules.required]"
            variant="outlined"
            required
          />

          <!-- Vessel -->
          <v-select
            v-model="form.vessel_id"
            :items="vessels"
            item-title="name"
            item-value="id"
            label="Vessel (optional)"
            prepend-inner-icon="mdi-ferry"
            variant="outlined"
          />

          <!-- Service Line -->
          <v-select
            v-model="form.service_line_id"
            :items="serviceLines"
            item-title="name"
            item-value="id"
            label="Service Line (optional)"
            prepend-inner-icon="mdi-route-variant"
            variant="outlined"
          />

          <v-text-field
  label="Assigned To"
  :model-value="currentUserName"
  prepend-inner-icon="mdi-account"
  readonly
  variant="outlined"
/>

          <v-divider class="my-6" />

          <!-- Buttons -->
          <v-row justify="end">
            <v-btn variant="outlined" color="grey" class="mr-4" @click="cancel">
              Cancel
            </v-btn>
            <v-btn
              color="primary"
              type="submit"
              :loading="loading"
              :disabled="!valid || loading"
            >
              Create Ticket
            </v-btn>
          </v-row>

          <!-- Error Alert -->
          <v-alert
            v-if="errorMessage"
            type="error"
            density="compact"
            class="mt-6"
            icon="mdi-alert-circle"
          >
            {{ errorMessage }}
          </v-alert>
        </v-form>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import api from '@/plugins/axios'

const router = useRouter()
const valid = ref(false)
const loading = ref(false)
const errorMessage = ref('')
const formRef = ref(null)

/* ---------------- FORM ---------------- */
const form = ref({
  title: '',
  description: '',
  contact_email: '',
  cc_email: '',
  priority: 'Medium',
  organization_id: null,
  vessel_id: null,
  service_line_id: null,
  category: null,
  status: 'Open',
})

/* ---------------- DROPDOWNS ---------------- */
const priorities = ['High', 'Medium', 'Low']
const categories = ['Fish', 'Crustaceans', 'Mollusks', 'Other']
const statuses = ['Open', 'In Progress', 'Resolved', 'Closed']
const organizations = ref([])
const vessels = ref([])
const serviceLines = ref([])

/* ---------------- RULES ---------------- */
const rules = {
  required: v => !!v || 'This field is required',
  email: v => /.+@.+\..+/.test(v) || 'Invalid email format',
}

/* ---------------- CURRENT USER ---------------- */
const currentUserName = computed(() => {
  const user = localStorage.getItem('user')
  return user ? JSON.parse(user).name : '-'
})

/* ---------------- STATUS COLOR ---------------- */
const statusColor = computed(() => {
  const s = form.value.status
  if (s === 'Closed' || s === 'Resolved') return 'success'
  if (s === 'In Progress') return 'warning'
  return 'info'
})

/* ---------------- LOAD DATA ---------------- */
onMounted(async () => {
  try {
    const [orgRes, vesRes, slRes] = await Promise.all([
      api.get('/organizations'),
      api.get('/vessels'),
      api.get('/service-lines'),
    ])

    organizations.value = orgRes.data || []
    vessels.value = vesRes.data || []
    serviceLines.value = slRes.data || []
  } catch (err) {
    console.error(err)
    errorMessage.value = 'Failed to load required data'
  }
})

/* ---------------- CREATE TICKET ---------------- */
const createTicket = async () => {
  const { valid: isValid } = await formRef.value.validate()
  if (!isValid) return

  loading.value = true
  errorMessage.value = ''

  try {
    const res = await api.post('/tickets', form.value)
    alert(`Ticket created successfully! (#${res.data.ticket_number})`)
    router.push('/tickets')
  } catch (err) {
    errorMessage.value =
      err.response?.data?.message || 'Create ticket failed'
  } finally {
    loading.value = false
  }
}

const cancel = () => router.push('/tickets')
</script>
