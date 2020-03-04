<template>
  <div class="list">
    <h6>{{ list.name }}</h6>
    <listEdit :listEdit="listEdit"></listEdit>

    <draggable v-model="list.cards" :options="{group: 'cards'}" class="dragArea" @change="cardMoved">
      <card v-for="card in list.cards" :card="card" :list='list'></card>
    </draggable>

    <a v-if="!editing" v-on:click="startEditing">Add a card</a>
    <textarea v-if="editing" ref="message" v-model="message" class="form-control mb-1"></textarea>
    <button v-if="editing" v-on:click="submitMessage" class="btn btn-secondary">Add</button>
    <a v-if="editing" v-on:click="editing=false">Cancel</a>

  </div>
</template>

<script>
import draggable from 'vuedraggable'
import card from 'components/card'
import listEdit from 'components/listEdit'

export default {
  components: { card, draggable, listEdit },
  props: ["list"],

  data: function() {
    return {
      listEdit: this.list,
      editing: false,
      message: ""
    }
  },

  methods: {
    // リスト(name)編集（モーダル）
    closeModal: function(event) {
      if (event.target.classList.contains("modal")) { this.editing = false }
    },

  //   save: function() {
  //     var data = new FormData
  //     data.append("list[name]", this.name)

  //     Rails.ajax({
  //       beforeSend: () => true,
  //       url: `/lists/${this.list.id}`,
  //       type: "PATCH",
  //       data: data,
  //       dataType: "json",
  //       success: (data) => {
  //         const list_index = window.store.lists.findIndex((item) => item.id == this.list.id)
  //         window.store.lists.splice(list_index, 1, data)
  //         this.editing = false
  //       }
  //     })
  //   },

    // destroy: function() {
    //   var data = new FormData
    //   data.append("list[name]", this.name)

    //   Rails.ajax({
    //     beforeSend: () => true,
    //     url: `/lists/${this.list.id}`,
    //     type: "DELETE",
    //     data: data,
    //     dataType: "json",
    //     success: (data) => {
    //       const list_index = window.store.lists.findIndex((item) => item.id == this.list.id)
    //       window.store.lists.splice(list_index, 1)
    //       this.editing = false
    //     }
    //   })
    // },

    startEditing: function() {
      this.editing = true
      this.$nextTick(() => { this.$refs.message.focus() }) //カード追加時にフォームを入力状態にする
    },

        // カードのソートと別リストへの移動
    cardMoved: function(event) {
      const evt = event.added || event.moved
      if (evt == undefined) { return }

      const element = evt.element 
      const list_index = window.store.lists.findIndex((list) => {
        return list.cards.find((card) => {
          return card.id === element.id
        })
      })

      var data =  new FormData
      data.append("card[list_id]", window.store.lists[list_index].id)
      data.append("card[position]", evt.newIndex + 1)

      Rails.ajax({
        url: `/cards/${element.id}/move`,
        type: "PATCH",
        data: data,
        dataType: "json"
      })
    },

     // カードの新規作成
    submitMessage: function() {
      var data = new FormData
      data.append("card[list_id]", this.list.id)
      data.append("card[name]", this.message)

      Rails.ajax({
        url: "/cards",
        type: "POST",
        data: data,
        dataType: "json",
        beforeSend: function() { return true },
        success: (data) => {
          const index = window.store.lists.findIndex(item => item.id == this.list.id)
          window.store.lists[index].cards.push(data)
          this.message = ""
          this.$nextTick(() => { this.$refs.message.focus() }) //カード追加時に次のフォームを入力状態にする
        }
      })
    }
  }
}
</script>

<style scoped>

.dragArea {
  min-height: 10px;
}


</style>