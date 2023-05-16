import express from 'express'
import helmet from 'helmet'
import cors from 'cors'
import compression from 'compression'

const app = express()

app.use(express.json())
app.use(cors())
app.use(compression())
app.use(helmet())

app.listen(3000, () => {
    console.log('App listening on port 3000')
})

const router = express.Router()

router.get('/', (req, res) => {
    console.log('This is / route')
    res.send('This is / route')
})

router.get('/hello', (req, res) => {    
    res.send('Hello')
})

app.use(router)
