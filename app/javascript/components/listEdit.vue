<template>
  <div class="list_edit">
    <div @click="editing=true" class="mb-3">編集</div>
    <div v-if='editing' class="modal-backdrop show"></div>
    <div v-if='editing' @click="closeModal" class="modal show" style="display: block">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ list.name }}</h5>
          </div>
          <div class="modal-body">
            <input v-model="name" class="form-control"></input>
          </div>
          <div class="modal-footer">
            <button @click="save" type="button" class="btn btn-primary">Save changes</button>
            <button @click="destroy" type="button" class="btn btn-primary">Delete</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>



<script>
export default {
  props: ['listEdit'],
  data: function() {
    return {
      editing: false,
      name: this.list.name,
    }
  },

  methods: {
    // リスト(name)編集（モーダル）
    closeModal: function(event) {
      if (event.target.classList.contains("modal")) { this.editing = false }
    },

    save: function() {
      var data = new FormData
      data.append("list[name]", this.name)

      Rails.ajax({
        beforeSend: () => true,
        url: `/lists/${this.list.id}`,
        type: "PATCH",
        data: data,
        dataType: "json",
        success: (data) => {
          const list_index = window.store.lists.findIndex((item) => item.id == this.list.id)
          window.store.lists.splice(list_index, 1, data)
          this.editing = false
        }
      })
    },
    
    // リスト削除
     destroy: function() {
      var data = new FormData
      data.append("list[name]", this.name)

      Rails.ajax({
        beforeSend: () => true,
        url: `/lists/${this.list.id}`,
        type: "DELETE",
        data: data,
        dataType: "json",
        success: (data) => {
          const list_index = window.store.lists.findIndex((item) => item.id == this.list.id)
          window.store.lists.splice(list_index, 1)
          this.editing = false
        }
      })
    },

  }
}
</script>

<style scoped>
</style>