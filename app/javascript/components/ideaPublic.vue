<template>
  <div>
    <comment v-for="idea in ideas" :key="idea.id" :idea="idea" :comment="comment">
    </comment>
  </div>
</template>

<script>
import comment from 'components/comment'

export default {
  components: { comment },
  props: ["comment_ideas"],
  data: function() {
    return{
      ideaPublic: this.comment_ideas,
      ideas: this.comment_ideas,
      editing: false,
      message: "",
      comment: "",
    }
  },

}
</script>



<style lang="scss" scoped>

.public_idea{
  display: flex;
}

</style>