import { onMounted } from "vue";
export default {
    setup(props) {
        // lifecycle hooks
        onMounted(() => {
            console.log(`The initial of Dashboard Page`);
            console.log(import.meta.env.VITE_DOMAIN_BE);
        });

        return;
    }
}