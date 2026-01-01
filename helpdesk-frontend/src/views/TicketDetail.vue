<template>
  <v-container fluid class="pa-6">
    <v-row justify="center">
      <v-col cols="12" lg="11">
        <v-card-title class="text-h4 font-weight-bold mb-8 primary--text">Ticket Details</v-card-title>

        <v-row>

          <v-col cols="12" lg="6">
            <v-card color="surface" class="rounded-xl overflow-hidden elevation-6">
              <v-row no-gutters class="border-sm">

                <v-col cols="9" class="px-8 py-4">
                  <!-- Title + edit -->
                  <div class="d-flex align-center">
                    <h2 class="text-xl font-weight-bold mx-0">Ticket</h2>
                  </div>
                  <!-- Subtitle / Request -->
                  <div>
                    <span class="text-body-1 text-grey mb-10" v-if="!editTitle">
                      {{ ticket.title }}
                    </span>
                    <v-btn v-if="!editTitle" icon @click="editTitle = true" size="small">
                      <v-icon>mdi-pencil</v-icon>
                    </v-btn>
                    <v-text-field v-else v-model="ticket.title" variant="solo" density="compact" hide-details autofocus
                      @blur="editTitle = false" @keyup.enter="editTitle = false"></v-text-field>
                  </div>



                  <!-- Ticket ID -->
                  <div>
                    <strong class="text-grey">Ticket Id:</strong>
                    <span class="text-indigo-lighten-2 ml-2 font-medium">{{ ticket.ticket_number || '#??????' }}</span>
                  </div>

                  <!-- Created -->
                  <div>
                    <strong class="text-grey">Created:</strong>
                    <span class="ml-2">{{ formatDate(ticket.created_at) }}</span>
                  </div>

                  <!-- Contact + edit -->
                  <div class="d-flex align-center">
                    <strong class="text-grey">Contact:</strong>
                    <span v-if="!editContact" class="ml-2">{{ ticket.contact_email }}</span>
                    <v-btn v-if="!editContact" icon @click="editContact = true" size="x-small" class="ml-2">
                      <v-icon size="18">mdi-pencil</v-icon>
                    </v-btn>
                    <v-text-field v-else v-model="ticket.contact_email" variant="solo" density="compact" hide-details
                      class="ml-2" style="max-width: 300px;" @blur="editContact = false"
                      @keyup.enter="editContact = false"></v-text-field>
                  </div>

                  <!-- Cc Email -->
                  <div class="mb-6">
                    <strong class="text-grey">Cc Email:</strong>
                    <span class="ml-2">{{ ticket.cc_email || '—' }}</span>
                  </div>

                  <!-- Description -->
                  <div class="text-body-1 text-grey-lighten-1">
                    {{ ticket.description || 'No description provided.' }}
                  </div>
                </v-col>


                <v-col cols="3" class="  border-s-sm">
                  <div class="d-flex justify-end mr-4 my-4">
                    <!-- ไอคอนตั๋ว -->
                    <v-icon size="24" color="amber-accent-2">mdi-ticket</v-icon>
                  </div>

                  <!-- Priority -->
                  <div class="d-flex flex-column text-center mb-6 justify-center align-center pa-4 ">
                    <v-chip :color="priorityColor" label size="large" class="text-h6 font-weight-bold px-6 py-2">
                      {{ ticket.priority?.toUpperCase() || 'MEDIUM' }}
                    </v-chip>
                    <div class="text-caption text-grey mt-1">ticket priority</div>
                  </div>

                  <!-- Time remaining -->
                  <div class="text-center">
                    <div class="text-xl font-weight-bold">{{ timeRemaining }}</div>
                    <div class="text-caption text-grey mt-1">time remaining</div>
                  </div>
                </v-col>
              </v-row>
            </v-card>
          </v-col>

          <!-- Organization & Category  -->
          <v-col cols="6" lg="3">
            <!-- Organization -->
            <v-card color="surface" class="mb-6 rounded-xl elevation-6 py-4">
              <v-card-title class="text-h6">
                <v-icon class="mr-2" color="amber">mdi-anchor</v-icon>
                Organization
              </v-card-title>
              <v-card-text>
                <v-select v-model="ticket.organization_id" :items="organizations" item-title="name" item-value="id"
                  variant="outlined" density="compact" prepend-inner-icon="mdi-domain"
                  :loading="loadingData"></v-select>

                <v-select v-model="ticket.vessel_id" :items="vessels" item-title="name" item-value="id" label="Vessel"
                  variant="outlined" density="compact" prepend-inner-icon="mdi-ferry"></v-select>

                <v-text-field label="Assigned To" :model-value="ticket.assigned_user?.name || '-'"
                  prepend-inner-icon="mdi-account" readonly variant="outlined" density="compact" hide-details />

              </v-card-text>
            </v-card>
          </v-col>
          <v-col cols="6" lg="3">
            <!-- Category & Status -->
            <v-card color="surface" class="rounded-xl elevation-6 pt-4">
              <v-card-title class="text-h6">
                <v-icon class="mr-2" color="warning">mdi-lock</v-icon>
                Category & Status
              </v-card-title>
              <v-card-text>
                <v-select v-model="ticket.category" :items="categories" label="Category" variant="outlined"
                  density="compact" prepend-inner-icon="mdi-lock-outline"></v-select>

                <v-select v-model="ticket.status" :items="statuses" label="Status" variant="outlined" density="compact"
                  prepend-inner-icon="mdi-checkbox-marked-circle"></v-select>

                <v-select v-model="ticket.service_line_id" :items="serviceLines" item-title="name" item-value="id"
                  label="Service Line" variant="outlined" density="compact" prepend-inner-icon="mdi-route"></v-select>
              </v-card-text>
            </v-card>
          </v-col>
        </v-row>


        <v-row justify="end" class="mt-8">
          <v-btn color="grey" variant="outlined" class="mr-4" @click="cancel">
            Cancel
          </v-btn>
          <v-btn color="primary" @click="saveTicket" :loading="saving">
            Save Changes
          </v-btn>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import api from '@/plugins/axios'


const route = useRoute()
const router = useRouter()

const saving = ref(false)
const loadingData = ref(true)

const editTitle = ref(false)
const editContact = ref(false)

const ticket = ref({
  id: null,
  title: '',
  description: '',
  priority: 'High',
  contact_email: '',
  cc_email: '',
  created_at: '',
  organization_id: null,
  vessel_id: null,
  service_line_id: null,
  assigned_user_id: null,
  status: 'Open',
  category: '',
})

const organizations = ref([])
const vessels = ref([])
const serviceLines = ref([])
const users = ref([])

const categories = ref(['Fish', 'Crustaceans', 'Mollusks', 'Other'])
const statuses = ref(['Open', 'In Progress', 'Resolved', 'Closed'])

const priorityColor = computed(() => {
  const p = ticket.value.priority?.toLowerCase()
  if (p === 'high') return 'error'
  if (p === 'medium') return 'warning'
  return 'success'
})

const timeRemaining = computed(() => '11h 57min')

const formatDate = (date) =>
  date
    ? new Date(date).toLocaleString('en-GB', {
      day: '2-digit',
      month: 'short',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    })
    : '-'

onMounted(async () => {
  loadingData.value = true
  const id = route.params.id

  try {
    const [ticketRes, orgRes, vesRes, slRes] = await Promise.all([
      api.get(`/tickets/${id}`),
      api.get('/organizations'),
      api.get('/vessels'),
      api.get('/service-lines'),
    ])

    const t = ticketRes.data


    ticket.value = {
      ...t,
      organization_id: t.organization?.id ?? t.organization_id ?? null,
      vessel_id: t.vessel?.id ?? t.vessel_id ?? null,
      service_line_id: t.service_line?.id ?? t.service_line_id ?? null,
      assigned_user_id: t.assigned_user?.id ?? t.assigned_user_id ?? null,
    }

    organizations.value = orgRes.data || []
    vessels.value = vesRes.data || []
    serviceLines.value = slRes.data || []

    
    try {

      users.value = userRes.data || []
    } catch {
      console.warn('⚠️ /api/users not found → skip Assigned To')
      users.value = []
    }
  } catch (e) {
    console.error('Error loading data:', e)
  } finally {
    loadingData.value = false
  }
})

const saveTicket = async () => {
  saving.value = true

  try {
    const payload = {
      title: ticket.value.title,
      description: ticket.value.description,
      priority: ticket.value.priority,
      contact_email: ticket.value.contact_email,
      cc_email: ticket.value.cc_email,
      status: ticket.value.status,
      category: ticket.value.category,
      organization_id: ticket.value.organization_id,
      vessel_id: ticket.value.vessel_id,
      service_line_id: ticket.value.service_line_id,
    }

    await api.put(`/tickets/${ticket.value.id}`, payload)

    alert('successfully! ')
    router.push('/tickets')
  } catch (e) {
    alert(e.response?.data?.message || 'Save failed')
    console.error(e)
  } finally {
    saving.value = false
  }
}

const cancel = () => router.push('/tickets')
</script>
