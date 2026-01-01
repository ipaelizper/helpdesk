<template>
  <v-container fluid class="pa-6">
    <v-row align="center" class="mb-6">
      <v-col>
        <h1 class="text-h4 font-weight-bold">Ticket List</h1>
      </v-col>
      <v-col cols="auto">
        <v-btn color="primary" prepend-icon="mdi-plus" @click="goToCreate" size="large">
          Add New Ticket
        </v-btn>
      </v-col>
    </v-row>


    <v-card elevation="4" class="rounded-lg">
      <v-card-text>
        <v-data-table-server v-model:items-per-page="itemsPerPage" v-model:page="page" :headers="headers"
          :items="tickets" :items-length="totalTickets" :loading="loading" :search="search" item-value="id"
          class="elevation-0" @update:options="loadTickets">

          <template v-slot:item.priority="{ item }">
            <v-chip :color="getPriorityColor(item.priority)" label size="small"
              class="text-uppercase font-weight-medium">
              {{ item.priority }}
            </v-chip>
          </template>

          <template v-slot:item.organization="{ item }">
            {{ item.organization?.name || '-' }}
          </template>

          <template v-slot:item.vessel="{ item }">
            {{ item.vessel?.name || '-' }}
          </template>

          <template v-slot:item.created_at="{ item }">
            {{ formatDate(item.created_at) }}
          </template>

          <template v-slot:item.actions="{ item }">
            <v-tooltip bottom>
              <template v-slot:activator="{ props }">
                <v-btn icon size="small" variant="text" color="primary" v-bind="props" @click="viewTicket(item.id)">
                  <v-icon>mdi-eye</v-icon>
                </v-btn>
              </template>
              <span>View Details</span>
            </v-tooltip>

            <v-tooltip bottom>
              <template v-slot:activator="{ props }">
                <v-btn icon size="small" variant="text" color="error" v-bind="props" @click="confirmDelete(item)">
                  <v-icon>mdi-delete</v-icon>
                </v-btn>
              </template>
              <span>Delete Ticket</span>
            </v-tooltip>
          </template>
        </v-data-table-server>
      </v-card-text>
    </v-card>


    <v-dialog v-model="deleteDialog" max-width="400">
      <v-card>
        <v-card-title class="text-h6">Confirm Delete</v-card-title>
        <v-card-text>
          Are you sure you want to delete ticket "{{ deleteItem?.title }}"? This action cannot be
          undone.
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="grey" variant="text" @click="deleteDialog = false"> Cancel </v-btn>
          <v-btn color="error" variant="text" @click="deleteTicket"> Delete </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import api from '@/plugins/axios'

const router = useRouter()

// Table state
const tickets = ref([])
const totalTickets = ref(0)
const loading = ref(false)
const page = ref(1)
const itemsPerPage = ref(10)
const search = ref('')

// Delete dialog
const deleteDialog = ref(false)
const deleteItem = ref(null)

// Headers 
const headers = [
  { title: 'ID', key: 'ticket_number' },
  { title: 'Title', key: 'title' },
  { title: 'Priority', key: 'priority' },
  { title: 'Organization', key: 'organization' },
  { title: 'Vessel', key: 'vessel' },
  { title: 'Created At', key: 'created_at' },
  { title: 'Actions', key: 'actions', align: 'end' },
]

// Priority colors
const getPriorityColor = (priority) => {
  switch (priority?.toLowerCase()) {
    case 'high': return 'error'
    case 'medium': return 'warning'
    case 'low': return 'success'
    default: return 'grey'
  }
}

// Format date
const formatDate = (date) =>
  date
    ? new Date(date).toLocaleDateString('th-TH', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
      })
    : '-'


const loadTickets = async (options = {}) => {
  loading.value = true
  try {
    const response = await api.get('/tickets', {
      params: {
        page: options.page ?? page.value,
        per_page: options.itemsPerPage ?? itemsPerPage.value,
        search: options.search ?? search.value,
      },
    })

    tickets.value = response.data.data
    totalTickets.value = response.data.total
    page.value = response.data.current_page
  } catch (error) {
    console.error('Failed to load tickets:', error)
  } finally {
    loading.value = false
  }
}

// Initial load
onMounted(() => {
  loadTickets()
})

// Navigation
const goToCreate = () => router.push('/tickets/create')
const viewTicket = (id) => router.push(`/tickets/${id}`)

// Delete
const confirmDelete = (item) => {
  deleteItem.value = item
  deleteDialog.value = true
}

const deleteTicket = async () => {
  if (!deleteItem.value) return

  try {
    await api.delete(`/tickets/${deleteItem.value.id}`)
    await loadTickets()
    alert('Ticket deleted successfully')
  } catch (error) {
    alert(error.response?.data?.message || error.message)
  } finally {
    deleteDialog.value = false
    deleteItem.value = null
  }
}
</script>
