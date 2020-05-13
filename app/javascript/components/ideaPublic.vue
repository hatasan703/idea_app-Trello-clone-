<template>
  <div>
    <comment v-for="idea in ideas" :key="idea.id" :idea="idea">
    </comment>
  </div>
</template>

<script>
import comment from 'components/comment'

export default {
  components: { comment },
  props: {
    public_ideas: '',
  },
  data: function() {
    return{
      ideaPublic: this.public_ideas,
      ideas: this.public_ideas,
      editing: false,
      message: "",
    }
  },

}
</script>



<style lang="scss" scoped>

.public_idea{
  display: flex;
}

</style>