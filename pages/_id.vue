<template>
  <v-container text-center wrap md12>
    <v-simple-table>
      <template v-slot:default>
        <thead>
          <tr>
            <th style="text-align: left;">
              ID
            </th>
            <th style="text-align: left;">
              Title
            </th>
            <th style="text-align: left;">
              Content
            </th>
            <th />
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>
              {{ id }}
            </td>
            <td>
              <v-text-field v-model="title" placeholder="New Title" />
            </td>
            <td>
              <v-text-field v-model="content" placeholder="New Content" />
            </td>
            <td>
              <v-btn @click="updateTask()" dark>
                UPDATE
              </v-btn>
            </td>
          </tr>
          <tr>
            <td />
            <td />
            <td />
            <td>
              <v-btn @click="removeTask()" color="#FF5252">
                DELETE
              </v-btn>
            </td>
          </tr>
        </tbody>
      </template>
    </v-simple-table>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      id: 0,
      title: '',
      content: ''
    }
  },
  async asyncData({ $axios, route }) {
    const id = route.params.id

    const res = await $axios.$get(`/task/${id}`)
    return { id: res.id, title: res.title, content: res.content }
  },
  methods: {
    updateTask() {
      const id = this.id
      const data = {
        title: this.title,
        content: this.content
      }

      this.$axios
        .$put(`/task/${id}`, data)
        .then((response) => {
          console.log('response data', response)
          this.$router.push('/')
        })
        .catch((error) => {
          console.log('response error', error)
        })
    },
    removeTask() {
      const id = this.id

      this.$axios
        .$delete(`/task/${id}`)
        .then((response) => {
          console.log('response data', response)
          this.$router.push('/')
        })
        .catch((error) => {
          console.log('response error', error)
        })
    }
  }
}
</script>
