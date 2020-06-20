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
          <tr v-for="task in tasks" :key="task.id">
            <td>{{ task.id }}</td>
            <td>{{ task.title }}</td>
            <td>{{ task.content }}</td>
            <td>
              <nuxt-link :to="`/${task.id}`" style="text-decoration: none;">
                <v-btn>
                  EDIT
                </v-btn>
              </nuxt-link>
            </td>
          </tr>
          <tr>
            <td>
              -
            </td>
            <td>
              <v-text-field v-model="newTitle" placeholder="New Title" />
            </td>
            <td>
              <v-text-field v-model="newContent" placeholder="New Content" />
            </td>
            <td>
              <v-btn @click="addTask()" dark>
                ADD
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
      tasks: [],
      newTitle: '',
      newContent: ''
    }
  },
  async asyncData({ $axios }) {
    const res = await $axios.get('/tasks')
    console.log(res)
    return { tasks: res.data }
  },
  methods: {
    addTask() {
      const data = {
        title: this.newTitle,
        content: this.newContent
      }

      this.$axios
        .$post('/task', data)
        .then((response) => {
          console.log('response data', response)

          this.tasks.push(response)
        })
        .catch((error) => {
          console.log('response error', error)
        })

      this.newTitle = ''
      this.newContent = ''
    }
  }
}
</script>
